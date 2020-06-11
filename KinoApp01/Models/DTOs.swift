//
//  DTOs.swift
//  KinoApp01
//
//  Created by jose francisco morales on 12/06/2020.
//  Copyright © 2020 jose francisco morales. All rights reserved.
//

import Foundation

// MARK: - DTOs

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let poster_path: String?
    
    var poster: URL? { poster_path.map { MoviesAPI.imageBase.appendingPathComponent($0) } }
}

struct MovieDetailDTO: Codable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String?
    let vote_average: Double?
    let genres: [GenreDTO]
    let release_date: String?
    let runtime: Int?
    let spoken_languages: [LanguageDTO]
    
    var poster: URL? { poster_path.map { MoviesAPI.imageBase.appendingPathComponent($0) } }
    
    struct GenreDTO: Codable {
        let id: Int
        let name: String
    }
    
    struct LanguageDTO: Codable {
        let name: String
    }
}

struct PageDTO<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}
