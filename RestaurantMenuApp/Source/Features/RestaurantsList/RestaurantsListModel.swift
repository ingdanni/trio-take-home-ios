//
//  RestaurantsListModel.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 12/1/22.
//

import SwiftUI

final class RestaurantsListModel {
    
    private let repository: RestaurantProvider
    
    @Published var list: [Restaurant] = []
    
    init(repository: RestaurantProvider) {
        self.repository = repository
    }
    
    func fetchRestaurants(state: String, page: Int) {
        repository.fetchRestaurants(state: state, page: page) { response in
            switch response {
            case let .success(res):
                self.list = res.data
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
