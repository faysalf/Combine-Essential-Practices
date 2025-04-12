//
//  MoviesViewModels.swift
//  MoviesApp-SwiftUI
//
//  Created by Md. Faysal Ahmed on 13/4/25.
//

import SwiftUI
import Combine

class MoviesViewModels: ObservableObject {
    
    @Published private(set) var movies: [Movie] = []
    @Published var isFetchingMoviesContinuous: Bool = false
    
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
                guard let self else { return }

                self.isFetchingMoviesContinuous = true
                self.loadMovies(query: searchText)
            }.store(in: &cancellables)
        
    }
    
    func setSearchText(_ searchText: String) {
        searchSubject.send(searchText)
    }
    
    func loadMovies(query: String) {
        httpClient.fetchMovies(query: query)
            .sink { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .finished:
                    self.isFetchingMoviesContinuous = false
                case .failure(let error):
                    debugPrint("Error happend: \(error)")
                }
                
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
        
    }
}
