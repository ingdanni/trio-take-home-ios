//
//  RestaurantMenuPresenter.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import Combine
import SwiftUI

class RestaurantMenuPresenter: ObservableObject {
    
    private let router = RestaurantMenuRouter()
    private let interactor: RestaurantMenuInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var restaurant: Restaurant
    @Published var categories: [String] = []
    @Published var selectedCategory: String = ""
    @Published var list: [MenuItem] = []
    
    init(restaurant: Restaurant, interactor: RestaurantMenuInteractor) {
        self.restaurant = restaurant
        self.interactor = interactor
        
        interactor.model.$categories.sink(receiveValue: { items in
            self.categories = items
            self.selectedCategory = items.first ?? ""
            
            self.list = interactor.model.list.filter {
                $0.subsection == self.selectedCategory
            }
        })
        .store(in: &cancellables)
        
        $selectedCategory.sink(receiveValue: { item in
            self.list = interactor.model.list.filter {
                $0.subsection == item
            }
        })
        .store(in: &cancellables)
        
        interactor.fetchMenuItems(restaurantId: restaurant.restaurantID)
    }
}
