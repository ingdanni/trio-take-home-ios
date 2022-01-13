//
//  RestaurantsListRouter.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import SwiftUI

class RestaurantsListRouter {
    
    func makeDetailView(for restaurant: Restaurant) -> some View {
        // TODO: Change provider
        RestaurantMenuConfigurator.configure(restaurant: restaurant, provider: MockRestaurantRepository())
    }
}
