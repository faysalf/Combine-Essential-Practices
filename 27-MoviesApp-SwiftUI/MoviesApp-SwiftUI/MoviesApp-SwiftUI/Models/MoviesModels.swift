//
//  MoviesModels.swift
//  MoviesApp-SwiftUI
//
//  Created by Md. Faysal Ahmed on 13/4/25.
//

import Foundation

struct MoviesModels: Decodable {
    let Search : [Movie]
    
}

struct Movie: Identifiable, Decodable {
    let title: String
    let year: String
    let imdbId: String
    let poster: URL?
    
    var id : String { imdbId }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
    
}
