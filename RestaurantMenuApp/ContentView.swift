//
//  ContentView.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 7/1/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let repository = RestaurantRepository(configuration: .default)
            
            repository.fetchRestaurants(state: "NY", page: 1, completion: {
                print($0)
            })
            
            repository.fetchMenuItems(restaurantId: 4310410377884499, completion: {
                print($0)
            })
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
