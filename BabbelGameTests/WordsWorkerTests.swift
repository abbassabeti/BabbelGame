//
//  WordsWorkerTests.swift
//  BabbelGameTests
//
//  Created by Abbas Sabeti on 27/02/2022.
//

import XCTest
@testable import BabbelGame
class WordsWorkerTests: XCTestCase {
    
    var worker : WordsWorkerProtocol?
    
    override func setUpWithError() throws {
        worker = WordsWorker()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfCanFetchWords() throws {
        guard let count = worker?.words.count else {
            fatalError("Could not fetch the words")
        }
        XCTAssertGreaterThan(count, 0, "Failed in getting any words")
    }
    
    func testIfNextWordsIncreaseIndex() throws {
        guard let worker = worker else {fatalError("Failed in initialing WordWorker")}
        let incrementExpectation = expectation(description: "Increase index on each nextWord action")
        incrementExpectation.expectedFulfillmentCount = 10
        
        for _ in 1...10{
            let index = worker.lastIndex
            _ = worker.getNextWord()
            if (worker.lastIndex - index == 1){
                incrementExpectation.fulfill()
            }
        }
        wait(for: [incrementExpectation], timeout: 3.0)
    }
    
    func testIfRenumerationOfWordListIsPossible() throws {
        guard let worker = worker else {fatalError("Failed in initialing WordWorker")}
        let recurringExpectation = expectation(description: "Failed in recurring enumeration over words")
        recurringExpectation.expectedFulfillmentCount = 6
        
        let count = worker.words.count
        for _ in 1...count * 6{
            _ = worker.getNextWord()
            let index = worker.lastIndex
            if (index == 0){
                recurringExpectation.fulfill()
            }
        }
        wait(for: [recurringExpectation], timeout: 3.0)
    }
    
    func testIfWordsCanHaveWrongMeaning() throws {
        guard let worker = worker else {fatalError("Failed in initialing WordWorker")}
        var fakeMeaningExpectation : XCTestExpectation? = expectation(description: "Words doesn't have wrong meaning")
        
        let count = worker.words.count
        for _ in 1...count{
            let word = worker.getNextWord()
            if word?.lastShownMeaning != word?.meaning {
                fakeMeaningExpectation?.fulfill()
                fakeMeaningExpectation = nil
            }
        }
        waitForExpectations(timeout: 3)
    }
}
