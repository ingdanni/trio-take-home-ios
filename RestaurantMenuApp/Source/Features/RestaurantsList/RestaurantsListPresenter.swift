//
//  RestaurantsListPresenter.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import Combine

class RestaurantsListPresenter: ObservableObject {
    
    private let router = RestaurantsListRouter()
    private let interactor: RestaurantsListInteractor
    
    init(interactor: RestaurantsListInteractor) {
        self.interactor = interactor
    }
}
