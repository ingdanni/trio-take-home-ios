//
//  RestaurantsResource.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

enum RestaurantResource: Resource {
    case fetchRestaurants(String, Int)
    case fetchMenuItems(Int)
    
    var resource: (method: HTTPMethod, route: String, contentType: ContentType?) {
        switch self {
        case .fetchRestaurants(let state, let page):
            return (.get, "/restaurants/state/\(state)?size=100&page=\(page)", .json)
        case .fetchMenuItems(let restaurantId):
            return (.get, "/restaurant/\(restaurantId)/menuitems", .json)
        }
    }
}
