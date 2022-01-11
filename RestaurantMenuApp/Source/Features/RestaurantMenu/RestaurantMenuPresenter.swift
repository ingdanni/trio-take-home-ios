//
//  RestaurantMenuPresenter.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import Combine

class RestaurantMenuPresenter: ObservableObject {
    
    private let router = RestaurantMenuRouter()
    private let interactor: RestaurantMenuInteractor
    
    init(interactor: RestaurantMenuInteractor) {
        self.interactor = interactor
    }
}
