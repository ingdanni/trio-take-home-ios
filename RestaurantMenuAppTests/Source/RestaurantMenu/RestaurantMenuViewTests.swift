//
//  RestaurantMenuViewTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 14/1/22.
//

import XCTest
import ViewInspector
import SwiftUI

@testable import RestaurantMenuApp

class RestaurantMenuViewTests: XCTestCase {
    
    var repository: MockRestaurantRepository!
    var view: RestaurantMenuView!
    var model: RestaurantMenuModel!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        model = RestaurantMenuModel(repository: repository)
        view = RestaurantMenuView(
            presenter: RestaurantMenuPresenter(
                restaurant: makeRestaurant(),
                interactor: RestaurantMenuInteractor(
                    model: model)))
    }

    override func tearDownWithError() throws {
        repository = nil
        model = nil
        view = nil
    }
    
    func test_fetchMenuItems_loadingState() throws {
        ViewHosting.host(view: view, size: nil)
        
        XCTAssertNoThrow(try view
                            .inspect()
                            .find(viewWithId: "loadingView"))
    }
    
    func test_fetchMenuItems_loadedState() throws {
        let expectation = XCTestExpectation(
            description: "fetch menu items")
        
        ViewHosting.host(view: view, size: nil)
        
        _ = model.$list.assign(to: \.list, on: view.presenter)
        _ = model.$state.assign(to: \.state, on: view.presenter)
        _ = view.presenter
            .$list
            .sink(receiveValue: { value in
                guard !value.isEmpty else { return }
            
                expectation.fulfill()
            })
        
        XCTAssertNoThrow(try view
                            .inspect()
                            .find(viewWithId: "menuItemsView"))
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItems_emptyState() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(
            description: "fetch menu items")
        
        ViewHosting.host(view: view, size: nil)
        
        _ = model.$list.assign(to: \.list, on: view.presenter)
        _ = model.$state.assign(to: \.state, on: view.presenter)
        _ = view.presenter
            .$list
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
        
        XCTAssertNoThrow(try view
                            .inspect()
                            .find(viewWithId: "emptyMessageView"))
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItems_errorState() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch menu items")
        
        ViewHosting.host(view: view, size: nil)
        
        _ = model.$list.assign(to: \.list, on: view.presenter)
        _ = model.$state.assign(to: \.state, on: view.presenter)
        _ = view.presenter
            .$list
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
        
        XCTAssertNoThrow(try view
                            .inspect()
                            .find(viewWithId: "errorMessageView"))
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItems() throws {
        let expectation = XCTestExpectation(
            description: "fetch menu items")
        
        view.presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            guard !value.isEmpty else { return }
            
            expectation.fulfill()
        })
        
        XCTAssertFalse(model.list.isEmpty)
        XCTAssertFalse(model.categories.isEmpty)
        XCTAssert(model.list.count == 25)
        XCTAssert(model.state == .loaded)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItemsEmpty() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(
            description: "fetch menu items")
        
        view.presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.categories.isEmpty)
        XCTAssert(model.state == .empty)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchMenuItemsError() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch menu items")
        
        view.presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.categories.isEmpty)
        XCTAssert(model.state == .error)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_restaurantHeaderView() throws {
        let sut = RestaurantHeader(title: "title", subtitle: "subtitle")
        
        let title = try sut.inspect()
            .vStack()
            .text(0)
            .string()
        
        let subtitle = try sut.inspect()
            .vStack()
            .text(2)
            .string()
        
        XCTAssert(title == "title")
        XCTAssert(subtitle == "subtitle")
    }
    
    func test_menuItemView() throws {
        let sut = MenuItemView(name: "name", description: "desc", price: "0.0")
        
        let name = try sut.inspect()
            .vStack()
            .text(0)
            .string()
        
        let description = try sut.inspect()
            .vStack()
            .text(1)
            .string()
        
        let price = try sut.inspect()
            .vStack()
            .text(2)
            .string()
        
        XCTAssert(name == "name")
        XCTAssert(description == "desc")
        XCTAssert(price == "0.0")
    }
    
    func test_menuCategorySelector() throws {
        let selected = Binding<String>(wrappedValue: "First")
        let sut = MenuCategorySelector(tabs: ["First", "Second", "Third"], selected: selected)
        
        try sut.inspect()
            .find(button: "SECOND")
            .tap()
        
        XCTAssert(selected.wrappedValue == "Second")
        
        try sut.inspect()
            .find(button: "THIRD")
            .tap()
        
        XCTAssert(selected.wrappedValue == "Third")
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

// MARK: Inspectable conformance

extension RestaurantMenuView: Inspectable {}

extension RestaurantHeader: Inspectable {}

extension MenuItemView: Inspectable {}

extension MenuCategorySelector: Inspectable {}
