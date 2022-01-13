//
//  MockClient.swift
//  RestaurantMenuAppTests
//
//  Created by Danny Narvaez on 13/1/22.
//

import Foundation

class MockClient {
    
    func loadFrom<T: Decodable>(_ file: String, type: T.Type) -> T {
        let bundle = Bundle(for: MockClient.self)
        
        guard let url = bundle.url(forResource: file, withExtension: "json"),
              let jsonData = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(T.self, from: jsonData) else {
            abort()
        }
        
        return response
    }
}
