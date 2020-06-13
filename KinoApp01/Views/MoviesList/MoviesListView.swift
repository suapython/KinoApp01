//
//  MoviesListView.swift
//  ModernMVVM
//
//  Created by Vadym Bulavin on 2/20/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import Combine
import SwiftUI

struct MoviesListView: View {
   let listArray: [Endpoint] = [.popular,.topRated,.upcoming,.nowPlaying,.trending]
    
    @ObservedObject var viewModel: MoviesListViewModel 
        
    var body: some View {
        NavigationView {
            content
               // .navigationBarTitle("Trending Movies")
        }
        .onAppear { self.viewModel.send(event: .onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let movies):
            return list(of: movies).eraseToAnyView()
        }
    }
    
    private func list(of movies: [ListItem]) -> some View {
         
        return  VStack(alignment: .leading){
            Text("Popular")
                           .font(.headline)
                           .padding(.leading, 15)
                           .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
            ForEach(movies) {movie in
            NavigationLink(
                destination: MovieDetailView(viewModel: MovieDetailViewModel(movieID: movie.id)),
                label: { MovieListItemView(movie: movie) }
            )
                    }
                } 
            }
    }
}
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel(list: .popular))
    }
}
