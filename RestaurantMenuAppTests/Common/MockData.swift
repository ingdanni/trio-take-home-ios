//
//  MockData.swift
//  RestaurantMenuAppUITests
//
//  Created by Danny Narvaez on 12/1/22.
//

@testable import RestaurantMenuApp

struct MockData {

    static func makeRestaurants() -> Response<[Restaurant]> {
        let restaurants = [
        Restaurant(restaurantName: "Monalisa Pasta",
                   restaurantPhone: "+123456789",
                   restaurantWebsite: "www.monalisa.com",
                   hours: "", priceRange: "",
                   priceRangeNum: 100,
                   restaurantID: 1,
                   cuisines: ["Italian"],
                   lastUpdated: ""),
        Restaurant(restaurantName: "Rock & Pasta",
                   restaurantPhone: "+123456000",
                   restaurantWebsite: "www.rocknpasta.com",
                   hours: "",
                   priceRange: "",
                   priceRangeNum: 100,
                   restaurantID: 2,
                   cuisines: ["Italian", "Mediterranean"],
                   lastUpdated: ""),
        ]

        return Response(totalResults: restaurants.count,
                        totalPages: 1,
                        morePages: false,
                        data: restaurants)
    }

    static func makeRestaurant() -> Restaurant {
        Restaurant(restaurantName: "Rock & Pasta",
                   restaurantPhone: "+123456000",
                   restaurantWebsite: "www.rocknpasta.com",
                   hours: "",
                   priceRange: "",
                   priceRangeNum: 100,
                   restaurantID: 1,
                   cuisines: ["Italian"],
                   lastUpdated: "")
    }
    
    static func makeMenuItems(restaurantID: Int) -> Response<[MenuItem]> {
        let items = [
            makeMenuItem(id: "1", restaurantID: restaurantID, category: "Small salad"),
            makeMenuItem(id: "2", restaurantID: restaurantID, category: "Small salad"),
            makeMenuItem(id: "3", restaurantID: restaurantID, category: "Desserts"),
            makeMenuItem(id: "4", restaurantID: restaurantID, category: "Desserts"),
            makeMenuItem(id: "5", restaurantID: restaurantID, category: "Pasta"),
            makeMenuItem(id: "6", restaurantID: restaurantID, category: "Pasta"),
            makeMenuItem(id: "7", restaurantID: restaurantID, category: "Pizza"),
            makeMenuItem(id: "8", restaurantID: restaurantID, category: "Pizza"),
        ]
        
        return Response<[MenuItem]>(totalResults: 1, totalPages: 1, morePages: false, data: items)
    }
    
    static func makeMenuItem(id: String, restaurantID: Int, category: String) -> MenuItem {
        MenuItem(itemID: id,
                 menuItemDescription: "Reid’s Orchard Pears / Bitter Greens / Granola / Firefly Farms Black and Blue / Pine Nut Vinaigrette",
                 menuItemName: "Pear Salad - \(category)",
                 menuItemPricing: [MenuItemPricing(price: 10, currency: "$", priceString: "10$")],
                 menuItemPrice: 10,
                 priceRange: "",
                 restaurantHours: "",
                 restaurantID: restaurantID,
                 restaurantName: "",
                 restaurantPhone: "",
                 subsection: category,
                 subsectionDescription: category)
    }
}
