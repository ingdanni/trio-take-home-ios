//
//  RestaurantMenuConfigurator.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

class RestaurantMenuConfigurator {
    
    static func configure() -> RestaurantMenuView {
        RestaurantMenuView(
            presenter: RestaurantMenuPresenter(
                interactor: RestaurantMenuInteractor(
                    repository: RestaurantRepository(
                        configuration: .default))))
    }
}
