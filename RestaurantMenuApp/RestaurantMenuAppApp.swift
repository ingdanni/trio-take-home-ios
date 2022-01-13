//
//  RestaurantMenuAppApp.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 7/1/22.
//

import SwiftUI

@main
struct RestaurantMenuAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            RestaurantsListConfigurator.configure()
        }
    }
}
