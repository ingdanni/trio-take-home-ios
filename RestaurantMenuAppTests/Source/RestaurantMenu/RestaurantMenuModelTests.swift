//
//  RestaurantMenuModelTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 14/1/22.
//

import XCTest

@testable import RestaurantMenuApp

class RestaurantMenuModelTests: XCTestCase {
    
    var model: RestaurantMenuModel!
    var repository: MockRestaurantRepository!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        
        model = RestaurantMenuModel(
            repository: repository)
    }

    override func tearDownWithError() throws {
        model = nil
    }

    func test_fetchMenuItems() throws {
        let expectation = XCTestExpectation(
            description: "fetch menu items from model")
        
        model.fetchMenuItems(restaurantId: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 25)
        XCTAssertFalse(model.categories.isEmpty)
        XCTAssert(model.categories.count == 6)
        XCTAssert(model.state == .loaded)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItemsEmpty() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(
            description: "fetch menu items from model")
        
        model.fetchMenuItems(restaurantId: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.categories.isEmpty)
        XCTAssert(model.state == .empty)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItemsFailed() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch menu items from model")
        
        model.fetchMenuItems(restaurantId: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.categories.isEmpty)
        XCTAssert(model.state == .error)
        
        wait(for: [expectation], timeout: 0.5)
    }
}
