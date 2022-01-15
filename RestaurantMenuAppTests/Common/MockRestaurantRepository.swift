//
//  MockRestaurantRepository.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

@testable import RestaurantMenuApp

enum KindOfResponse {
    case loaded
    case empty
    case error
}

class MockRestaurantRepository: MockClient, RestaurantProvider {
    
    var kindOfResponse: KindOfResponse = .loaded
    
    func fetchMenuItems(restaurantId: Int, completion: @escaping (Result<Response<[MenuItem]>, HTTPClientError>) -> Void) {
        switch kindOfResponse {
        case .loaded:
            let response = loadFrom("menu_items_list", type: Response<[MenuItem]>.self)
            completion(.success(response))
        case .empty:
            let response = loadFrom("menu_items_list_empty", type: Response<[MenuItem]>.self)
            completion(.success(response))
        case .error:
            completion(.failure(.httpError(.notFound)))
        }
    }
    
    func fetchRestaurants(state: String, page: Int, completion: @escaping (Result<Response<[Restaurant]>, HTTPClientError>) -> Void) {
        switch kindOfResponse {
        case .loaded:
            let response = loadFrom("restaurants_list", type: Response<[Restaurant]>.self)
            completion(.success(response))
        case .empty:
            let response = loadFrom("restaurants_list_empty", type: Response<[Restaurant]>.self)
            completion(.success(response))
        case .error:
            completion(.failure(.httpError(.notFound)))
        }
    }
}
