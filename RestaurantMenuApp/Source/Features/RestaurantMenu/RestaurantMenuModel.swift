//
//  RestaurantMenuModel.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 12/1/22.
//

import SwiftUI

final class RestaurantMenuModel {
    
    private let repository: RestaurantProvider
    
    @Published var list: [MenuItem] = []
    @Published var categories: [String] = []
    
    init(repository: RestaurantProvider) {
        self.repository = repository
    }
    
    func fetchMenuItems(restaurantId: Int) {
        repository.fetchMenuItems(restaurantId: restaurantId) { response in
            switch response {
            case let .success(res):
                self.list = res.data
                let subsections = res.data.map { $0.subsection }
                let uniques = Set(subsections)
                self.categories = Array(uniques)
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
