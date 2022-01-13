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
        
        interactor.model.$categories
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { items in
                self.categories = items
                self.selectedCategory = items.first ?? ""
                
                self.list = interactor.model.list.filter {
                    $0.subsection == self.selectedCategory
                }
            })
            .store(in: &cancellables)
        
        $selectedCategory
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { item in
                self.list = interactor.model.list.filter {
                    $0.subsection == item
                }
            })
            .store(in: &cancellables)
    }
    
    func load() {
        interactor.fetchMenuItems(restaurantId: restaurant.restaurantID)
    }
}
