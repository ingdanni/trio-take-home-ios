//
//  MenuItem.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

struct MenuItem: Codable {
    let itemID: String
    let menuItemDescription: String
    let menuItemName: String
    let menuItemPricing: [MenuItemPricing]
    let menuItemPrice: Double
    let priceRange: String
    let restaurantHours: String
    let restaurantID: Int
    let restaurantName: String
    let restaurantPhone: String
    let subsection: String
    let subsectionDescription: String
    
    var price: String {
        menuItemPricing.first?.priceString ?? "$0.0"
    }

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case menuItemDescription = "menu_item_description"
        case menuItemName = "menu_item_name"
        case menuItemPricing = "menu_item_pricing"
        case menuItemPrice = "menu_item_price"
        case priceRange = "price_range"
        case restaurantHours = "restaurant_hours"
        case restaurantID = "restaurant_id"
        case restaurantName = "restaurant_name"
        case restaurantPhone = "restaurant_phone"
        case subsection
        case subsectionDescription = "subsection_description"
    }
}

struct MenuItemPricing: Codable {
    let price: Double
    let currency: String
    let priceString: String
}
