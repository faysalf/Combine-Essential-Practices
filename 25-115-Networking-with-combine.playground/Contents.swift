//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

/*
{
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  }
*/

enum NetworkError: Error {
    case httpError
}

struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

typealias PostsModel = [PostModel]

func fetchPost() -> AnyPublisher<PostsModel, Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/postss")! //working url: "https://jsonplaceholder.typicode.com/posts"
    
    return URLSession.shared.dataTaskPublisher(for: url)
        //.map(\.data)                  // For regular use
        .tryMap{ (data, response) in    // For handling error
            print("Retries ")
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.httpError
            }
            return data
        }
        .decode(type: PostsModel.self, decoder: JSONDecoder())
        .retry(3)                       // for retrying 3 times if any error occures
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    
}


var cancellables: Set<AnyCancellable> = []

fetchPost()
    .sink { completion in
        switch completion {
        case .finished:
            print("UI Update")
            
        case .failure(let error):
            print("Error happedn: \(error)")
        }
    } receiveValue: { posts in
        print("first post is here:", posts.first)
    }
    .store(in: &cancellables)


