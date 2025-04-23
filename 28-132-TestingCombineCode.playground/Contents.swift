//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine
import XCTest

class BasicCombineTest : XCTestCase {
    
    func testCombineCodes() {
        //Combine works asynchronously — so if we don't use expectations, our test method might finish before the Combine pipeline runs.
        let expectation = XCTestExpectation(description: "Received value")
        
        let publisher = Just("Hello Swift Community")
            
        let _ = publisher
            .sink { value in
                XCTAssertEqual(value, "Hello Swift Community")
                expectation.fulfill()           // Tell XCTest that we are done
            }
        
        wait(for: [expectation], timeout: 3.0) // Wait for async work, but not more than 3 seconds
        
    }
    
}


BasicCombineTest.defaultTestSuite.run()
