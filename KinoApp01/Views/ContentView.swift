//
//  ContentView.swift
//  KinoApp01
//
//  Created by jose francisco morales on 11/06/2020.
//  Copyright © 2020 jose francisco morales. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let listArray: [Endpoint] = [.popular,.topRated,.upcoming,.nowPlaying,.trending]
    
    var body: some View {
        NavigationView {
                   List {
                ForEach(listArray, id: \.self) {list in
                        MoviesListView(viewModel: MoviesListViewModel(list: list)  )
                    }
                }.navigationBarTitle(Text("Featured"))
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
