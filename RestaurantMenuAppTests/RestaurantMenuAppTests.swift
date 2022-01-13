//
//  RestaurantMenuAppTests.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 7/1/22.
//

import XCTest
import ViewInspector

@testable import RestaurantMenuApp

extension RestaurantsListView: Inspectable {}

extension RestaurantItemView: Inspectable {}

class RestaurantMenuAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_listItems() throws {
//        let sut = RestaurantsListConfigurator.configure(provider: MockRestaurantRepository())
//
//        let navigation = try sut.inspect().navigationView()
//        let scrollView = try navigation.scrollView(0)
//        let lazyVStack = try scrollView.lazyVStack()
//        let forEach = try lazyVStack.forEach(0)
        
        // TODO: Test forEach
    }
    
    func test_navigationTitle() throws {
        let sut = RestaurantsListConfigurator.configure(provider: MockRestaurantRepository())
        
        let title = try sut.inspect().navigationView().find(text: "Restaurants in NY").string()
        
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
