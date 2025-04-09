//
//  MoviesViewModel.swift
//  MoviesApp-UIKit
//
//  Created by Md. Faysal Ahmed on 9/4/25.
//

import Foundation
import Combine

class MoviesViewModel {
    
    @Published private(set) var movies: [Movie] = []
    @Published var loadingCompleted: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        setupSearchPublisher()
    }
    
    private func setupSearchPublisher() {
        
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.loadMovies(query: searchText)
            }.store(in: &cancellables)
        
    }
    
    func setSearchText(_ searchText: String) {
        searchSubject.send(searchText)
    }
    
    func loadMovies(query: String) {
        httpClient.fetchMovies(query: query)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    self?.loadingCompleted = true
                case .failure(let error):
                    debugPrint("Error happend: \(error)")
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)

    }
    
    
}
