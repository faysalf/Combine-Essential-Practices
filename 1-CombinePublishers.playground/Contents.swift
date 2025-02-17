import UIKit
import Combine


let publisher = Just("Hello World")

let cancellable = publisher.sink { value in
    print(value)
}

// Cancellable is not required. Bcz, once the scope goes out, it will automatically be cancelled.
//cancellable.cancel()



let numPublisher = [2, 3, 4, 6, 8, 12, 11].publisher
let tenthPublisher = numPublisher.map { $0 * 10 } //if we use a publisher in a map, it will return another publisher

tenthPublisher.sink { value in
    print(value)
}

