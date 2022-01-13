//
//  RestaurantsListViewTests.swift
//  RestaurantsListViewTests
//
//  Created by Danny Narvaez on 7/1/22.
//

import XCTest
import ViewInspector

@testable import RestaurantMenuApp

class RestaurantsListViewTests: XCTestCase {
    
    var view: RestaurantsListView!
    var model: RestaurantsListModel!

    override func setUpWithError() throws {
        model = RestaurantsListModel(repository: MockRestaurantRepository())
        
        view = RestaurantsListView(
            presenter: RestaurantsListPresenter(
                interactor: RestaurantsListInteractor(
                    model: model)))
    }

    override func tearDownWithError() throws {
        model = nil
        view = nil
    }
    
    func test_fetchRestaurants() throws {
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssert(model.list.count == 22)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_navigationTitle() throws {
        let title = try view
            .inspect()
            .view(RestaurantsListView.self)
            .navigationView()
            .find(text: "Restaurants in NY")
            .string()
        
        XCTAssertFalse(title.isEmpty)
    }
    
    func test_restaurantItemView() throws {
        let sut = RestaurantItemView(title: "title", subtitle: "subtitle")
        
        let vStack = try sut.inspect().vStack()
        let title = try vStack.text(0).string()
        let subtitle = try vStack.text(1).string()
        
        XCTAssert(title == "title")
        XCTAssert(subtitle == "subtitle")
    }
}

extension RestaurantsListView: Inspectable {}

extension RestaurantItemView: Inspectable {}
