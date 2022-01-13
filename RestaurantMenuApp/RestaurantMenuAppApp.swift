//
//  RestaurantMenuAppApp.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 7/1/22.
//

import SwiftUI

@main
struct RestaurantMenuAppApp: App {
    
    var body: some Scene {
        WindowGroup {
//            RestaurantMenuConfigurator.configure(restaurant: MockData.makeRestaurant(), provider: MockRestaurantRepository())
            RestaurantsListConfigurator.configure(provider: MockRestaurantRepository())
            
//            RestaurantsListConfigurator.configure()
//            RestaurantMenuConfigurator.configure()
        }
    }
}
