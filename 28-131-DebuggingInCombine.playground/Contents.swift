//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

let publisher = [1, 2, 3, 4].publisher


//Print is an operator that prints the value throught to it. Here, print displaying the values after maping and filtering
let cancellable = publisher
    .map { $0 * 3 }
    .filter { $0 & 1 == 0 } // filter even numbers
    .print("DEBUG-PRINT")
    .sink { value in
        print(value)
    }

print("\n------------------ DEBUG-PRINT-END ------------------\n\n")


// Here we handle the events earlier, so every value from publisher pass through it. But before calling sink, we called map and filter operator. that's why mapped and even numbers are displaying from sink operator (subscriber)
let _ = publisher
    .handleEvents { _ in
        print("Subscription Received")
    } receiveOutput: { value in
        print("receiveOutput")
        print(value)
    } receiveCompletion: { completion in
        print("receiveCompletion")
    } receiveCancel: {
        print("receiveCancel")
    }receiveRequest: { _ in
        print("receiveRequest")
    }
    .map { $0 * 3 }
    .filter { $0 & 1 == 0 }
    .sink { value in
        print("Sink value")
        print(value)
    }
    

print("\n------------------- Handling Events End ------------------\n\n")



let _ = publisher
    .map { $0 * 3 }
    .breakpoint(receiveOutput: { value in
        print("Received breakpoint value: \(value)")
        return value == 9          // if true, it will break the code. should be properly shown to the project codes
    })
    .sink { value in
        print("Received sink value")
        print(value)
    }
