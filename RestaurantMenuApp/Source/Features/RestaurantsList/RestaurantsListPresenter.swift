//
//  RestaurantsListPresenter.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import Combine
import SwiftUI

class RestaurantsListPresenter: ObservableObject {
    
    private let router = RestaurantsListRouter()
    private let interactor: RestaurantsListInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var list: [Restaurant] = []
    
    private var currentPage = 1
    
    private var selectedState = "NY"
    
    init(interactor: RestaurantsListInteractor) {
        self.interactor = interactor
        
        interactor.model.$list
            .receive(on: DispatchQueue.main)
            .assign(to: \.list, on: self)
            .store(in: &cancellables)
        
        // TODO: Handle pagination
        
        interactor.fetchRestaurants(state: selectedState, page: currentPage)
    }
    
    func restaurantLinkBuilder<Content: View>(for restaurant: Restaurant, @ViewBuilder content: () -> Content) -> some View {
        
        NavigationLink(destination: router.makeDetailView(for: restaurant)) {
            content()
        }
    }
}
