//
//  Response.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

struct Response<T: Codable>: Codable {
    let totalResults: Int
    let totalPages: Int
    let morePages: Bool
    let data: T

    enum CodingKeys: String, CodingKey {
        case totalResults
        case totalPages = "total_pages"
        case morePages = "more_pages"
        case data
    }
}
