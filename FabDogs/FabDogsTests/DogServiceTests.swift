//
//  DogServiceTests.swift
//  FabDogsTests
//
//  Created by Maria Gabriela Ayala on 4/18/23.
//

import XCTest
@testable import FabDogs

final class DogServiceTests: XCTestCase {
    
    var systemUnderTest: DogService!

    override func setUpWithError() throws {
        self.systemUnderTest = DogService()
        
    }

    override func tearDownWithError() throws {
        self.systemUnderTest = nil
        
    }

    func testAPI_returnsSuccessfulResult() throws {
        // Given
        var dogs: [Dog]!
        var error: Error?
        
        let promise = expectation(description: "Completion handler invoked")
        
        // When
        self.systemUnderTest.getDogs(completion: { data, shouldntHappen in
            dogs = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNotNil(dogs)
        XCTAssertNil(error)
    }
}
