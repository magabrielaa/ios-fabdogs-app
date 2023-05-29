//
//  DogTest.swift
//  FabDogsTests
//
//  Created by Maria Gabriela Ayala on 4/18/23.
//

import XCTest
@testable import FabDogs

final class DogTest: XCTestCase {

    func testDogDebugDescription() throws {
        // Given
        let subjectUnderTest = Dog(
            named: "Pipo",
            personality: "Affectionate until bored",
            activity: "Going for walks all day long",
            imageUrl: "https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-08/220805-border-collie-play-mn-1100-82d2f1.jpg"
        )
        
        // When
        let actualValue = subjectUnderTest.debugDescription
        
        // Then
        let expectedValue = "Dog(name: Pipo, personality: Affectionate until bored)"
        XCTAssertEqual(actualValue, expectedValue)
    }
}
