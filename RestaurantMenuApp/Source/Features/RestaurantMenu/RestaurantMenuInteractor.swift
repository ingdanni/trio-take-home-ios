//
//  RestaurantMenuInteractor.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

class RestaurantMenuInteractor {
    
    let model: RestaurantMenuModel
    
    init(model: RestaurantMenuModel) {
        self.model = model
    }
    
    func fetchMenuItems(restaurantId: Int) {
        model.fetchMenuItems(restaurantId: restaurantId)
    }
}
