//
//  MoviesApp_SwiftUITests.swift
//  MoviesApp-SwiftUITests
//
//  Created by Md. Faysal Ahmed on 24/4/25.
//

import XCTest
import Combine

final class MoviesApp_SwiftUITests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    
    func testExample() throws {
        let client = HTTPClient()
        let expectation = XCTestExpectation(description: "Recieve Movies")
        
        client.fetchMovies(query: "Batman")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error fetching movies: \(error)")
                }
            } receiveValue: { movies in
                XCTAssertTrue(!movies.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
        
    }

}
