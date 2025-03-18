import UIKit
import Combine


enum SampleError: Error {
    case operationFailed
}

let numbersPublisher = [1,2,3,4,5,6].publisher

let transformedPublisher1 = numbersPublisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return value
    }.catch { error in
        print(error)
        return Just(0)
    }

let cancellable1 = transformedPublisher1.sink { value in
    print(value)
}
//result 1 2 op.Failed 0
print("-------------- \n")


// replaceError with single value
let transformedPublisher2 = numbersPublisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return value * 2
    }.replaceError(with: -1)


let cancellable2 = transformedPublisher2.sink { value in
    print(value)
}
// result - 2 4 -1
print("-------------- \n")


// replaceError with another publisher
let fallbackPublisher = Just(-1)

let transformedPublisher3 = numbersPublisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return Just(value * 2)
}.replaceError(with: fallbackPublisher)

let cancellable3 = transformedPublisher3.sink { publisher in
    let _ = publisher.sink { value in
        print(value)
    }
}
// result: 2 4 -1
print("-------------- \n")


// retry
let publisher = PassthroughSubject<Int, Error>()

let retriedPublisher = publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return value
    }.retry(2)

let cancellable4 = retriedPublisher.sink { completion in
    switch completion {
        case .finished:
            print("Pubisher has completed.")
        case .failure(let error):
            print("Publisher failed with error \(error)")
    }
} receiveValue: { value in
    print(value)
}

publisher.send(1)
publisher.send(2)
publisher.send(3) // failed
publisher.send(4)
publisher.send(5)
publisher.send(3) // failed
publisher.send(6)
publisher.send(7)
publisher.send(3) // failed - Next will not executable as it is already returned 2 times failure (we declared)
publisher.send(8)
// result - 1 2 4 5 6 7 "Publisher failed with error operationFailed"

