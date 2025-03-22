//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

class EvenSubject<Failure: Error>: Subject {
    
    typealias Output = Int
    private let wrapped: PassthroughSubject<Int, Failure>
    
    init(initialValue: Int) {
        self.wrapped = PassthroughSubject()
        debugPrint("Initial Value: \(initialValue&1 == 0 ? initialValue: 0)")
        send(initialValue)
    }
    
    func send(subscription: any Subscription) {
        wrapped.send(subscription: subscription)
    }

    func send(_ value: Int) {
        if ((value&1) == 0){ // only pass even numbers
            wrapped.send(value)
        }
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Int == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
    
}

let evenSubject = EvenSubject<Never>(initialValue: 4)

let cancellable = evenSubject.sink { value in
    print("Passing value:", value)
}

evenSubject.send(20)
evenSubject.send(25)
evenSubject.send(30)
