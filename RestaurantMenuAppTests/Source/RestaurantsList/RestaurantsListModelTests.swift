//
//  DocumenuAPITests.swift
//  RestaurantsListModelTests
//
//  Created by Danny Narvaez on 13/1/22.
//

import XCTest

@testable import RestaurantMenuApp

class RestaurantsListModelTests: XCTestCase {
    
    var model: RestaurantsListModel!
    var repository: MockRestaurantRepository!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        
        model = RestaurantsListModel(repository: repository)
    }

    override func tearDownWithError() throws {
        model = nil
    }
    
    func test_fetchRestaurants() throws {
        let expectation = XCTestExpectation(description: "fetch restaurants from model")
        
        model.fetchRestaurants(state: "NY", page: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 22)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsFailed() throws {
        repository.kindOfTest = .failure
        
        let expectation = XCTestExpectation(description: "fetch restaurants from model")
        
        model.fetchRestaurants(state: "NY", page: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)

        wait(for: [expectation], timeout: 0.5)
    }
}
