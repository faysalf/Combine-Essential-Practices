//: A UIKit based Playground for presenting user interface

// Here we will combine existing operators
import UIKit
import Combine

extension Publisher {
    
    func mapAndFilter<T>(_ transform: @escaping (Output) -> T, _ filter: @escaping (T) -> Bool) -> AnyPublisher<T, Failure> {
        return self
            .map { transform($0) } //apply the transformation to each emitted value
            .filter { filter($0) } //filter the values that only meet the condition
            .eraseToAnyPublisher()
    }
    
}


// Usage
let arrPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
let cancellable = arrPublisher.mapAndFilter({ $0*5 }) { value in
    return (value & 1 == 0) // even numbers will be filtered only
}.sink { value in
    print(value)
}

