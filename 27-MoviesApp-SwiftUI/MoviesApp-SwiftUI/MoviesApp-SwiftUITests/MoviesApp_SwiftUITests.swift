//
//  MoviesApp_SwiftUITests.swift
//  MoviesApp-SwiftUITests
//
//  Created by Md. Faysal Ahmed on 24/4/25.
//

import XCTest
import Combine

final class MoviesApp_SwiftUITests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    
    func testExample() throws {
        
        let client = HTTPClient()
        let expectation = XCTestExpectation(description: "Receive Movies")
        
        client.fetchMovies(query: "Batman")
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("Network Fetch Finished Successfully")
                    break
                case .failure(let error):
                    XCTFail("Request Failed error \(error)")
                }
            } receiveValue: { movies in
                XCTAssertTrue(movies.count > 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
        
    }

}
