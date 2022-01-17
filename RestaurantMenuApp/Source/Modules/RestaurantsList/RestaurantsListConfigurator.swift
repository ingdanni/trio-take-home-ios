//
//  RestaurantsListConfigurator.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import SwiftUI

class RestaurantsListConfigurator {
    
    static func configure() -> RestaurantsListView {
        RestaurantsListView(
            presenter: RestaurantsListPresenter(
                interactor: RestaurantsListInteractor(
                    model: RestaurantsListModel(
                        repository: RestaurantRepository(
                            configuration: .default)))))
    }
    
    static func configure(provider: RestaurantProvider) -> RestaurantsListView {
        RestaurantsListView(
            presenter: RestaurantsListPresenter(
                interactor: RestaurantsListInteractor(
                    model: RestaurantsListModel(
                        repository: provider))))
    }
}
