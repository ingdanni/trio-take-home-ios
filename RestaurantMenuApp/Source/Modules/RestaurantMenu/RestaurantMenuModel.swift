//
//  RestaurantMenuModel.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 12/1/22.
//

import SwiftUI

enum RestaurantMenuState: String {
    case loading
    case loaded
    case empty
    case error
}

final class RestaurantMenuModel {
    
    private let repository: RestaurantProvider
    
    @Published var list: [MenuItem] = []
    @Published var categories: [String] = []
    @Published var state: RestaurantMenuState = .loading
    
    init(repository: RestaurantProvider) {
        self.repository = repository
    }
    
    func fetchMenuItems(restaurantId: Int) {
        repository.fetchMenuItems(restaurantId: restaurantId) { result in
            switch result {
            case let .success(response):
                let uniques = Set(response.data.map { $0.subsection })
                self.categories = Array(uniques)
                
                self.list = response.data
                self.state = self.list.isEmpty ? .empty : .loaded
                
            case .failure:
                self.state = .error
            }
        }
    }
}
