//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

extension Publisher where Output == Int {
    
    func fetchOddNumbers() -> AnyPublisher<Int, Failure> {
        return self.filter { $0&1 == 1 }
            .eraseToAnyPublisher()
    }
    
    func fetchGreater(than value: Int) -> AnyPublisher<Int, Failure> {
        return self.filter { $0 > value }
            .eraseToAnyPublisher()
    }
    
}


// Usage
let arrPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
let cancellable = arrPublisher.fetchOddNumbers()
    .sink { value in
        print(value)
    }

print("Greater than 5")
let _ = arrPublisher.fetchGreater(than: 5)
    .sink { value in
        print(value)
    }
