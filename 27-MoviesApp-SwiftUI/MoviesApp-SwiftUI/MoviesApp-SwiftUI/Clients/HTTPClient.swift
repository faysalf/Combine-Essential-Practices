//
//  HTTPClient.swift
//  MoviesApp-SwiftUI
//
//  Created by Md. Faysal Ahmed on 13/4/25.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
}

class HTTPClient {
    
    
    func fetchMovies(query: String) -> AnyPublisher<[Movie], Error> {
        guard let encodedQuery = query.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedQuery)&page=2&apiKey=564727fa") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MoviesModels.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movie], Error> in
                return Just([])                     // Publisher<[Movie], Never>
                    .setFailureType(to: Error.self) // Now: Publisher<[Movie], Error>
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
    
    
    
}
