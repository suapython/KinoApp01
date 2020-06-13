//
//  MovieListViewModel.swift
//  ModernMVVMList
//
//  Created by Vadim Bulavin on 3/17/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import Foundation
import Combine

final class MoviesListViewModel: ObservableObject {
    @Published private(set) var state: State
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init(list: Endpoint) {
        state = .idle(list)
        
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }
    
   // deinit {
     //   bag.removeAll()
   // }
    
    func send(event: Event) {
        input.send(event)
    }
}

// MARK: - Inner Types

extension MoviesListViewModel {
    enum State {
        case idle(Endpoint)
        case loading(Endpoint)
        case loaded([ListItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onSelectMovie(Endpoint)
        case onMoviesLoaded([ListItem])
        case onFailedToLoadMovies(Error)
    }
    
    struct MovieList {
        let results:  [ListItem]
        init(response: PageDTO<MovieDTO> ) {
            results = response.results.map(ListItem.init)
        }
        
    }
    
    
    
}

// MARK: - State Machine

extension MoviesListViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle(let list):
            switch event {
            case .onAppear:
                return .loading(list)
            default:
                return state
            }
        case .loading:
            switch event {
            case .onFailedToLoadMovies(let error):
                return .error(error)
            case .onMoviesLoaded(let movies):
                return .loaded(movies)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
        }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading(let list) = state else { return Empty().eraseToAnyPublisher() }
              
            return MoviesAPI.movieList(list: list)
                .map { $0.results.map(ListItem.init) }
                .map(Event.onMoviesLoaded)
                .catch { Just(Event.onFailedToLoadMovies($0)) }
                .eraseToAnyPublisher()
            
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}
