//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

// combineLatest
let publisher1 = CurrentValueSubject<Int, Never>(1)
let publisher2 = CurrentValueSubject<Int, Never>(2) // can be int string together

let combinedPublisher = publisher1.combineLatest(publisher2)

let cancellable = combinedPublisher.sink { (value1, value2) in
    print("Value 1: \(value1), Value 2: \(value2)")
}

publisher1.send(5)
publisher2.send(6)
print("------------")
// Result: (1, 2), (5, 2), (5, 6)


// zip / zip3
let publisher3 = [1, 2, 3, 4, 5].publisher
let publisher4 = ["Q", "R", "S", "T", "U"].publisher
let publisher5 = ["Hello world", "Of", "Swift", "Developer"].publisher

let zippedPublisher0 = publisher3.zip(publisher3, publisher4)
let zippedPublisher = Publishers.Zip3(publisher3, publisher4, publisher5)

let cancellable2 = zippedPublisher.sink { (value1, value2, value3) in
    print("Value 1: \(value1), Value 2: \(value2), Value 3: \(value3)")
}
print("------------")


// switchToLatest
let outerPublisher  = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
let innerPublisher2 = CurrentValueSubject<Int, Never>(2)

let cancellable3 = outerPublisher
    .switchToLatest()
    .sink { value in
        print(value)
    }

outerPublisher.send(AnyPublisher(innerPublisher1))
innerPublisher1.send(3)
innerPublisher1.send(4)

outerPublisher.send(AnyPublisher(innerPublisher2))
innerPublisher2.send(10)

innerPublisher1.send(100) // This wont be work as innerpublisher2 is currently assigned.
