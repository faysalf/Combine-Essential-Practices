import UIKit
import Combine

// map
let numberPublisher = (0..<5).publisher

let doubledPublisher = numberPublisher.map { "Item \($0*2)" }

let cancellable = doubledPublisher.sink { value in
    print(value)
}
print("------- \n")

// flatMap
let namePublisher = ["Faysal", "Ahmed", "Jobayer", "Yeasin"].publisher

let flatMapPublisher = namePublisher.flatMap { $0.publisher } // $0.publiser - as $0 define a string, and flatMap define every character of a string

let cancellable2 = flatMapPublisher.sink { value in
    print(value)
}
print("------- \n")


// Merge
let publisher1 = [1, 2, 3].publisher
let publisher2 = [5, 6, 7].publisher

let mergedPublisher = Publishers.Merge(publisher1, publisher2)

let cancellable3 = mergedPublisher.sink { value in
    print(value)
}
