//
//  RestaurantRepository.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

protocol RestaurantProvider {
    
    func fetchRestaurants(state: String, page: Int, completion: @escaping (Result<Response<[Restaurant]>, HTTPClientError>) -> Void)
    func fetchMenuItems(restaurantId: Int, completion: @escaping (Result<Response<[MenuItem]>, HTTPClientError>) -> Void)
}

class RestaurantRepository: HTTPClient, RestaurantProvider {
    
    func fetchRestaurants(state: String, page: Int, completion: @escaping (Result<Response<[Restaurant]>, HTTPClientError>) -> Void) {
        request(resource: RestaurantResource.fetchRestaurants(state, page),
                headers: [kApiKeyHeader: kApiKey],
                type: Response<[Restaurant]>.self,
                completion: completion)
    }
    
    func fetchMenuItems(restaurantId: Int, completion: @escaping (Result<Response<[MenuItem]>, HTTPClientError>) -> Void) {
        request(resource: RestaurantResource.fetchMenuItems(restaurantId),
                headers: [kApiKeyHeader: kApiKey],
                type: Response<[MenuItem]>.self,
                completion: completion)
    }
}
