//
//  Resource.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

public protocol Resource {
    
    var resource: (method: HTTPMethod, route: String, contentType: ContentType?) { get }
}
