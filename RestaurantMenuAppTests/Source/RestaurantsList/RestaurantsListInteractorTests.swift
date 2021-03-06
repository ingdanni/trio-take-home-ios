//
//  RestaurantsListInteractorTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

import XCTest

@testable import RestaurantMenuApp

class RestaurantsListInteractorTests: XCTestCase {
    
    var repository: MockRestaurantRepository!
    var model: RestaurantsListModel!
    var interactor: RestaurantsListInteractor!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        model = RestaurantsListModel(repository: repository)
        interactor = RestaurantsListInteractor(model: model)
    }

    override func tearDownWithError() throws {
        repository = nil
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
        XCTAssert(model.state == .loaded)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsEmpty() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(description: "fetch restaurants from interactor")
        
        interactor.fetchRestaurants(state: "NY", page: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .empty)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsFailed() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(description: "fetch restaurants from interactor")
        
        interactor.fetchRestaurants(state: "NY", page: 1)
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .error)
        
        wait(for: [expectation], timeout: 0.5)
    }
}
