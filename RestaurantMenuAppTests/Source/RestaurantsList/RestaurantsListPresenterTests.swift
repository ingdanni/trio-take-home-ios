//
//  RestaurantsListPresenterTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

import XCTest

@testable import RestaurantMenuApp

class RestaurantsListPresenterTests: XCTestCase {
    
    var repository: MockRestaurantRepository!
    var model: RestaurantsListModel!
    var interactor: RestaurantsListInteractor!
    var presenter: RestaurantsListPresenter!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        model = RestaurantsListModel(repository: repository)
        interactor = RestaurantsListInteractor(model: model)
        presenter = RestaurantsListPresenter(interactor: interactor)
    }

    override func tearDownWithError() throws {
        repository = nil
        model = nil
        interactor = nil
        presenter = nil
    }
    
    func test_fetchRestaurants() throws {
        let expectation = XCTestExpectation(
            description: "fetch restaurants from presenter")
        
        presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 22)
        XCTAssert(model.state == .loaded)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_fetchRestaurantsEmpty() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(
            description: "fetch restaurants from presenter")
        
        presenter.load()
        
        _ = model.$state.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .empty)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsFailed() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch restaurants from presenter")
        
        presenter.load()
        
        _ = model.$state.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .error)
        
        wait(for: [expectation], timeout: 0.5)
    }
}
