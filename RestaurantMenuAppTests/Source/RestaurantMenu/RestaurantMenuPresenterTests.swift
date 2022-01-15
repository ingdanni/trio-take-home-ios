//
//  RestaurantMenuPresenterTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 14/1/22.
//

import XCTest
@testable import RestaurantMenuApp

class RestaurantMenuPresenterTests: XCTestCase {
    
    var repository: MockRestaurantRepository!
    var model: RestaurantMenuModel!
    var interactor: RestaurantMenuInteractor!
    var presenter: RestaurantMenuPresenter!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        model = RestaurantMenuModel(repository: repository)
        interactor = RestaurantMenuInteractor(model: model)
        presenter = RestaurantMenuPresenter(
            restaurant: makeRestaurant(),
            interactor: interactor)
    }

    override func tearDownWithError() throws {
        repository = nil
        model = nil
        interactor = nil
        presenter = nil
    }
    
    func test_fetchMenuItems() throws {
        let expectation = XCTestExpectation(
            description: "fetch menu items from presenter")
        
        presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 25)
        XCTAssert(model.state == .loaded)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_fetchMenuItemsEmpty() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(
            description: "fetch menu items from presenter")
        
        presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .empty)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_fetchMenuItemsFailed() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch menu items from presenter")
        
        presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .error)
        
        wait(for: [expectation], timeout: 2)
    }
    
    private func makeRestaurant() -> Restaurant {
        Restaurant(restaurantName: "Mamma mia",
                   restaurantPhone: "",
                   restaurantWebsite: "",
                   hours: "",
                   priceRange: "",
                   priceRangeNum: 100,
                   restaurantID: 1,
                   cuisines: ["cuisine1", "cuisine2"],
                   lastUpdated: "")
    }

}
