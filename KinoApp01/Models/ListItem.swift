//
//  ListItem.swift
//  KinoApp01
//
//  Created by jose francisco morales on 11/06/2020.
//  Copyright © 2020 jose francisco morales. All rights reserved.
//

import Foundation

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
