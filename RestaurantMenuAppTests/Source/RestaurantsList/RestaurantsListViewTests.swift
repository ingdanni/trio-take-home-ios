//
//  RestaurantsListViewTests.swift
//  RestaurantsListViewTests
//
//  Created by Danny Narvaez on 7/1/22.
//

import XCTest
import ViewInspector
import SwiftUI
import Combine

@testable import RestaurantMenuApp

class RestaurantsListViewTests: XCTestCase {
    
    var repository: MockRestaurantRepository!
    var view: RestaurantsListView!
    var model: RestaurantsListModel!

    override func setUpWithError() throws {
        repository = MockRestaurantRepository()
        model = RestaurantsListModel(repository: repository)
        view = RestaurantsListView(
            presenter: RestaurantsListPresenter(
                interactor: RestaurantsListInteractor(
                    model: model)))
    }

    override func tearDownWithError() throws {
        repository = nil
        model = nil
        view = nil
    }
    
    func test_fetchRestaurantsList_loadingState() throws {
        ViewHosting.host(view: view, size: nil)
        
        XCTAssertNoThrow(try view
                            .inspect()
                            .find(viewWithId: "progressView"))
    }
    
    func test_fetchRestaurantsList_loadedState() throws {
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
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
                            .find(viewWithId: "restaurantList"))
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsList_emptyState() throws {
        repository.kindOfResponse = .empty
        
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
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
                            .find(viewWithId: "emptyMessage"))
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsList_errorState() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
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
                            .find(viewWithId: "errorMessage"))
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurants() throws {
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
        view.presenter.load()
        
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
        
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
        view.presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .empty)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_fetchRestaurantsFailed() throws {
        repository.kindOfResponse = .error
        
        let expectation = XCTestExpectation(
            description: "fetch restaurants from view")
        
        view.presenter.load()
        
        _ = model.$list.sink(receiveValue: { value in
            expectation.fulfill()
        })
        
        XCTAssert(model.list.isEmpty)
        XCTAssert(model.state == .error)
        
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

// MARK: Inspectable conformance

extension RestaurantsListView: Inspectable {}

extension RestaurantItemView: Inspectable {}
