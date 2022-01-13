//
//  MockRestaurantRepository.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

@testable import RestaurantMenuApp

enum KindOfTest {
    case success
    case failure
}

class MockRestaurantRepository: MockClient, RestaurantProvider {
    
    var kindOfTest: KindOfTest = .success
    
    func fetchMenuItems(restaurantId: Int, completion: @escaping (Result<Response<[MenuItem]>, HTTPClientError>) -> Void) {
        switch kindOfTest {
        case .success:
            let response = loadFrom("menu_items", type: Response<[MenuItem]>.self)
            completion(.success(response))
        case .failure:
            completion(.failure(.httpError(.notFound)))
        }
    }
    
    func fetchRestaurants(state: String, page: Int, completion: @escaping (Result<Response<[Restaurant]>, HTTPClientError>) -> Void) {
        switch kindOfTest {
        case .success:
            let response = loadFrom("restaurants_list", type: Response<[Restaurant]>.self)
            completion(.success(response))
        case .failure:
            completion(.failure(.httpError(.notFound)))
        }
    }
}
