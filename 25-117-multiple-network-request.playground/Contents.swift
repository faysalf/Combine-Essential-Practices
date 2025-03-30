//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

/*
 {
   "Search": [
     {
       "Title": "Batman: The Killing Joke",
       "Year": "2016",
       "imdbID": "tt4853102",
       "Type": "movie",
       "Poster": "https://m.media-amazon.com/images/M/MV5BMzJiZTJmNGItYTUwNy00ZWE2LWJlMTgtZjJkNzY1OTRiNTZlXkEyXkFqcGc@._V1_SX300.jpg"
     }
    ]
 }
*/

struct MoviewModel: Codable {
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Codable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

func fetchPost(query: String) -> AnyPublisher<MoviewModel, Error> {
    let url = URL(string: "https://www.omdbapi.com/?s=\(query)&page=2&apiKey=564727fa")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MoviewModel.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()                  // used to transmit into any publisher type
    
}


var cancellables: Set<AnyCancellable> = []

// we can use flatmap, merge for more network request here.
Publishers.CombineLatest(fetchPost(query: "batman"), fetchPost(query: "spiderman"))
    .sink { _ in
        
    } receiveValue: { (value1, value2) in
        print("Barman or value 1 fetched succesfully:", value1)
        print("Spiderman or value 2 fetched succesfully:", value1)
    }
    .store(in: &cancellables)

