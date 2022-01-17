//
//  RestaurantMenuConfigurator.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

class RestaurantMenuConfigurator {
    
    static func configure(restaurant: Restaurant) -> RestaurantMenuView {
        RestaurantMenuView(
            presenter: RestaurantMenuPresenter(
                restaurant: restaurant,
                interactor: RestaurantMenuInteractor(
                    model: RestaurantMenuModel(repository: RestaurantRepository(
                        configuration: .default)))))
    }
    
    static func configure(restaurant: Restaurant, provider: RestaurantProvider) -> RestaurantMenuView {
        RestaurantMenuView(
            presenter: RestaurantMenuPresenter(
                restaurant: restaurant,
                interactor: RestaurantMenuInteractor(
                    model: RestaurantMenuModel(repository: provider))))
    }
}
