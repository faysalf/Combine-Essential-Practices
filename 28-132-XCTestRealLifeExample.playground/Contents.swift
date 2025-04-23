//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine
import XCTest

/*
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
}
*/

struct POSTModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class NetworkCallTest: XCTestCase {
    
    func testNetworkRequest() {
        let expectation = XCTestExpectation(description: "Network Fetched")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: POSTModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("Network Fetch Finished Successfully")
                case .failure(let error):
                    XCTFail("Request Failed error \(error)")
                }
                
            } receiveValue: { postValue in
                XCTAssertEqual(postValue.id, 1)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5.0)
        
    }
    
}

NetworkCallTest.defaultTestSuite.run()


