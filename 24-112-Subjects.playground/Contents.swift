//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine

// Subjects: Publish the value, and they can also subscribe

/*
 PassthroughSubject (pts) vs CurrentValueSubject (cvs):
 
 1. Optional to store initial values into pts, where cvs must assign initial values.
 2. pts pass the values once run, doesn't retain any values. But cvs retain the last value of itself, and we can get this via 'cvs.value'
 */

let passThroughSubject = PassthroughSubject<String, Never>()

let cancellable1 = passThroughSubject.sink { value in
    print("Received value: \(value)")
}

passThroughSubject.send("Hello!")
passThroughSubject.send("Swift Community.")
print("------------------------\n")


// CurrentValueSubject
let currentValueSubject = CurrentValueSubject<Int, Never>(10)

let cancellable2 = currentValueSubject.sink { value in
    print("Received value: \(value)")
}

currentValueSubject.send(20)
print("Retain value of currentValueSubject: \(currentValueSubject.value)")
