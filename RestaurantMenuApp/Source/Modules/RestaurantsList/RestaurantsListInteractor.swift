//
//  RestaurantsListInteractor.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import SwiftUI

class RestaurantsListInteractor {
    
    let model: RestaurantsListModel
    
    init(model: RestaurantsListModel) {
        self.model = model
    }
    
    func fetchRestaurants(state: String, page: Int) {
        model.fetchRestaurants(state: state, page: page)
    }
}
