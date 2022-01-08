//
//  HTTPClientConfiguration.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

import Foundation

public struct HTTPClientConfiguration {
    
    public let baseURL: String
    public let apiKey: String
    
    public init(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    static var `default`: HTTPClientConfiguration {
        HTTPClientConfiguration(baseURL: kBaseUrl, apiKey: kApiKey)
    }
}
