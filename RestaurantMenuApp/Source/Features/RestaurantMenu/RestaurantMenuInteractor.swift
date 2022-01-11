//
//  RestaurantMenuInteractor.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

class RestaurantMenuInteractor {
    
    private let repository: RestaurantProvider
    
    init(repository: RestaurantProvider) {
        self.repository = repository
    }
}
