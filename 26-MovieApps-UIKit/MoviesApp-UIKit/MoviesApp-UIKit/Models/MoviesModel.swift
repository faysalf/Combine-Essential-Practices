//
//  MoviesModel.swift
//  MoviesApp-UIKit
//
//  Created by Md. Faysal Ahmed on 9/4/25.
//

/*
{
      "Title": "Batman: The Killing Joke",
      "Year": "2016",
      "imdbID": "tt4853102",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMzJiZTJmNGItYTUwNy00ZWE2LWJlMTgtZjJkNzY1OTRiNTZlXkEyXkFqcGc@._V1_SX300.jpg"
    }
*/

import Foundation

struct MoviesModel: Codable {
    let Search : [Movie]
    
}

struct Movie: Codable {
    let title: String
    let year: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
    
}

