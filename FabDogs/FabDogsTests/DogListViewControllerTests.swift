//
//  DogListViewControllerTests.swift
//  FabDogsTests
//
//  Created by Maria Gabriela Ayala on 4/18/23.
//

import XCTest
@testable import FabDogs

final class DogListViewControllerTests: XCTestCase {
    var systemUnderTest: DogListViewController!

    override func setUpWithError() throws {
        try super.setUpWithError ()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest = navigationController.topViewController as? DogListViewController
        
        UIApplication.shared.windows
            .filter{ $0.isKeyWindow}
            .first!
            .rootViewController = self.systemUnderTest
       
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.systemUnderTest.view)
    }

    func testTableView_loadsDogs() throws {
        // Given
        let mockDogService = MockDogService()
        let mockDogs = [
            Dog(named: "Pipo",
                personality: "Affectionate until bored",
                activity: "Going for walks all day long",
                imageUrl: "https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-08/220805-border-collie-play-mn-1100-82d2f1.jpg"),
            Dog(named: "Firulais",
                personality: "Aloof",
                activity: "Fetching everything",
                imageUrl: "https://publish.purewow.net/wp-content/uploads/sites/2/2021/06/smallest-dog-breeds-toy-poodle.jpg?fit=728%2C524"),
            Dog(named: "Lila",
                personality: "Sweet and playful",
                activity: "Chewing on toys",
                imageUrl: "https://www.akc.org/wp-content/uploads/2021/07/Cavalier-King-Charles-Spaniel-laying-down-indoors.jpeg")
        ]
        mockDogService.mockDogs = mockDogs
        
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.dogService = mockDogService
        
        // Make sure tableView is empty at first
        XCTAssertEqual(1, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        
        // When
        self.systemUnderTest.viewWillAppear(false)
        
        // Then
        XCTAssertEqual(mockDogs.count, self.systemUnderTest.myDogs.count)
        // Ensures number of mock dogs is equal to number of cells in table View, might not
        // necessarily pass 10:29
        XCTAssertEqual(mockDogs.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        
    }
    
    class MockDogService: DogService {
        var mockDogs: [Dog]?
        var mockError: Error?
        
        override func getDogs(completion: @escaping ([Dog]?, Error?) -> ()) {
            completion(mockDogs, mockError)
        }
    }
}
