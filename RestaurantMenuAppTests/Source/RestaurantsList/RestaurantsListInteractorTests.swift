//
//  RestaurantsListInteractorTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

import XCTest

@testable import RestaurantMenuApp

class RestaurantsListInteractorTests: XCTestCase {
    
    var model: RestaurantsListModel!
    var interactor: RestaurantsListInteractor!

    override func setUpWithError() throws {
        model = RestaurantsListModel(
            repository: MockRestaurantRepository())
        
        interactor = RestaurantsListInteractor(
            model: model)
    }

    override func tearDownWithError() throws {
        model = nil
        interactor = nil
    }
    
    func test_fetchRestaurants() {
        let expectation = XCTestExpectation(description: "fetch restaurants from interactor")
        
        interactor.fetchRestaurants(state: "NY", page: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 22)
        
        wait(for: [expectation], timeout: 0.5)
    }
}
