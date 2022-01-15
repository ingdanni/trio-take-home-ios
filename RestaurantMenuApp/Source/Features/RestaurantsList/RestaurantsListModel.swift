//
//  RestaurantsListModel.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 12/1/22.
//

import SwiftUI

enum RestaurantListState: String {
    case loading
    case loaded
    case empty
    case error
}

final class RestaurantsListModel {
    
    private let repository: RestaurantProvider
    
    @Published var list: [Restaurant] = []
    @Published var state: RestaurantListState = .loading
    
    init(repository: RestaurantProvider) {
        self.repository = repository
    }
    
    func fetchRestaurants(state: String, page: Int) {
        repository.fetchRestaurants(state: state, page: page) { result in
            switch result {
            case let .success(response):
                self.list = response.data
                self.state = self.list.isEmpty ? .empty : .loaded
                
            case .failure:
                self.state = .error
            }
        }
    }
}
