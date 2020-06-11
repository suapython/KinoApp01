//
//  Endpoint.swift
//  KinoApp01
//
//  Created by jose francisco morales on 11/06/2020.
//  Copyright © 2020 jose francisco morales. All rights reserved.
//

import Foundation

enum Endpoint {
    case popular, topRated, upcoming, nowPlaying, trending
     
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .trending:
            return "trending/movie/week"
        }
    }
    func title() -> String {
        switch self {
        case .popular:
            return "Populat"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        case .nowPlaying:
            return "Now playing"
        case .trending:
            return "Trending"
        }
    }
    
    
    
}
