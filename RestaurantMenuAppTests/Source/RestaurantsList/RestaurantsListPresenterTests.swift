//
//  RestaurantsListPresenterTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

import XCTest

@testable import RestaurantMenuApp

class RestaurantsListPresenterTests: XCTestCase {
    
    var model: RestaurantsListModel!
    var interactor: RestaurantsListInteractor!
    var presenter: RestaurantsListPresenter!

    override func setUpWithError() throws {
        model = RestaurantsListModel(
            repository: MockRestaurantRepository())
        
        interactor = RestaurantsListInteractor(
            model: model)
         
        presenter = RestaurantsListPresenter(
            interactor: interactor)
    }

    override func tearDownWithError() throws {
        model = nil
        interactor = nil
        presenter = nil
    }
    
    func test_fetchRestaurants() {
        let expectation = XCTestExpectation(description: "fetch restaurants from presenter")
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 22)
        
        wait(for: [expectation], timeout: 2)
    }
}
