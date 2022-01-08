//
//  Restaurant.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

struct Restaurant: Codable {
    let restaurantName: String
    let restaurantPhone: String
    let restaurantWebsite: String
    let hours: String
    let priceRange: String
    let priceRangeNum: Int
    let restaurantID: Int
    let cuisines: [String]
    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case restaurantName = "restaurant_name"
        case restaurantPhone = "restaurant_phone"
        case restaurantWebsite = "restaurant_website"
        case hours
        case priceRange = "price_range"
        case priceRangeNum = "price_range_num"
        case restaurantID = "restaurant_id"
        case cuisines
        case lastUpdated = "last_updated"
    }
}
