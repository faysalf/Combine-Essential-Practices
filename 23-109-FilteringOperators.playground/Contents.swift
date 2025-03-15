import UIKit
import Combine

// filter
let numberPublisher = (0...5).publisher

let oddPublisher = numberPublisher.filter { $0 % 2 == 1 }

let cancellable = oddPublisher.sink { value in
    print(value)
}
print("------- \n")


// compactMap - ignors null values
let stringPublisher = ["1", "2", "4", "F"].publisher

let compactPublisher = stringPublisher.compactMap { Int($0) }

let cancellable2 = compactPublisher.sink { value in
    print(value)
}
print("------- \n")


// debounce - used for ignoring/skipping something
let textPublisher = PassthroughSubject<String, Never>() // Never - error can't be occured

let debouncedPublisher = textPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)

let cancellable3 = debouncedPublisher.sink { value in
    print(value)
}

textPublisher.send("A")
textPublisher.send("B")
textPublisher.send("C")
textPublisher.send("D")
textPublisher.send("E")
textPublisher.send("F")
textPublisher.send("G")
textPublisher.send("H")
textPublisher.send("I")
textPublisher.send("J")
textPublisher.send("K")
