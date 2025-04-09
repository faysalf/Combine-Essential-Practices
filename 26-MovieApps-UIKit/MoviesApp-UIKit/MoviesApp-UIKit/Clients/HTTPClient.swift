//
//  HTTPClient.swift
//  MoviesApp-UIKit
//
//  Created by Md. Faysal Ahmed on 9/4/25.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
}

class HTTPClient {
    
    func fetchMovies(query: String) -> AnyPublisher<[Movie], Error> {
        
        guard let encodedQuery = query.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedQuery)&page=2&apiKey=564727fa")
        else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MoviesModel.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movie], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
}
