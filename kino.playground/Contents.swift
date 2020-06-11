import Foundation
import Combine

struct Feedback<State, Event> {
    let run: (AnyPublisher<State, Never>) -> AnyPublisher<Event, Never>
}

extension Feedback {
    init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == Event, Effect.Failure == Never {
        self.run = { state -> AnyPublisher<Event, Never> in
            state
                .map { effects($0) }
                .switchToLatest()
                .eraseToAnyPublisher()
        }
    }
}

class MoviesListViewModel: ObservableObject {
@Published private(set) var state = State.idle

private var bag = Set<AnyCancellable>()

private let input = PassthroughSubject<Event, Never>()


    
    
    
    enum State {
        case idle
        case loading
        case loaded([ListItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onSelectMovie(Int)
        case onMoviesLoaded([ListItem])
        case onFailedToLoadMovies(Error)
    }


}

struct ListItem: Identifiable {
    let id: Int
    let title: String
    let poster: URL?
    
    init(movie: MovieDTO) {
        id = movie.id
        title = movie.title
        poster = movie.poster
    }
}
