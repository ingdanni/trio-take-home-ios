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
    private var currentPage = 1
    private var selectedState = "NY"
    
    @Published var list: [Restaurant] = []
    @Published var state: RestaurantListState = .loading
    
    init(interactor: RestaurantsListInteractor) {
        self.interactor = interactor
        
        interactor.model.$list
            .receive(on: DispatchQueue.main)
            .assign(to: \.list, on: self)
            .store(in: &cancellables)
        
        interactor.model.$state
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    func load() {
        interactor.fetchRestaurants(state: selectedState, page: currentPage)
    }
    
    func restaurantLinkBuilder<Content: View>(for restaurant: Restaurant, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(for: restaurant)) {
            content()
        }
        .buttonStyle(.plain)
    }
}
