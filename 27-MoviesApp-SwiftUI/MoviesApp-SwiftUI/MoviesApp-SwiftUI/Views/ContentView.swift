//
//  ContentView.swift
//  MoviesApp-SwiftUI
//
//  Created by Md. Faysal Ahmed on 13/4/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var vm = MoviesViewModels(httpClient: HTTPClient())
    
    @State var searchText: String = ""
    @State var cancellables: Set<AnyCancellable> = []
    @State var progressBarOn: Bool = false
    
    var body: some View {
        VStack {
            List(vm.movies) { movie in
                HStack(alignment: .center, spacing: 16) {
                    
                    AsyncImage(url: movie.poster) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(movie.title)
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                vm.setSearchText(searchText)
            }
            .overlay {
                if progressBarOn {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
        }
        .padding()
        .onAppear() {
            checkIfLoadingCompleted()
        }
    }
    
    func checkIfLoadingCompleted() {
        vm.$isFetchingMoviesContinuous
            .receive(on: DispatchQueue.main)
            .sink { isContinuous in
                self.progressBarOn = isContinuous ? true : false
            }
            .store(in: &cancellables)
    }
    
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
