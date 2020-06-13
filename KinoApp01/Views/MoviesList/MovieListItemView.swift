//
//  MovieListIteView.swift
//  KinoApp01
//
//  Created by jose francisco morales on 12/06/2020.
//  Copyright © 2020 jose francisco morales. All rights reserved.
//

import SwiftUI

struct MovieListItemView: View {
    let movie: ListItem
    @Environment(\.imageCache) var cache: ImageCache

    var body: some View {
        VStack {
            poster
        }
    }
    
    private var title: some View {
        Text(movie.title)
            .font(.title)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
    
    private var poster: some View {
        movie.poster.map { url in
            AsyncImage(
                url: url,
                cache: cache,
                placeholder: spinner,
                configuration: { $0.resizable().renderingMode(.original) }
            )
        }
        .aspectRatio(contentMode: .fit)
            .frame(height: 300) // 2:3 aspect ratio
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}



//struct MovieListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListItemView()
//    }
//}
