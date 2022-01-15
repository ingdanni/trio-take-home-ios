//
//  RestaurantsListView.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import SwiftUI

struct RestaurantsListView: View {
    
    @ObservedObject var presenter: RestaurantsListPresenter
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    switch presenter.state {
                    case .loading:
                        ProgressView("Loading restaurants")
                            .id("progressView")
                    case .loaded:
                        restaurantsList
                            .id("restaurantList")
                    case .empty:
                        MessageView(content: "No restaurants found, try again later.")
                    case .error:
                        MessageView(content: "An error ocurred, try again later.")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(alignment: .leading) {
                        Text("Restaurants in NY")
                            .font(.montserratRegular(size: 20))
                    }
                }
            }
            .onAppear {
                presenter.load()
            }
        }
    }
    
    var restaurantsList: some View {
        Group {
            ForEach(presenter.list, id: \.restaurantID) { item in
                
                self.presenter.restaurantLinkBuilder(for: item, content: {
                    RestaurantItemView(
                        title: item.restaurantName,
                        subtitle: item.cuisinesString)
                })
            }
        }
    }
}

struct RestaurantItemView: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            
            Text(title)
                .font(Font.playfairDisplayRegular(size: 20))
                .padding(.bottom, 10)
            
            Text(subtitle)
                .font(Font.playfairDisplayRegular(size: 16))
                .foregroundColor(Color.customGray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
                .padding(.horizontal, 40)
            
            Rectangle()
                .fill(Color.customLightGray2)
                .frame(height: 0.5)
                .padding(.horizontal, 44)
        }
    }
}

#if DEBUG
struct RestaurantsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<5) { _ in
                    RestaurantItemView(
                        title: "Monalisa pasta & pizza",
                        subtitle: "Italian, pizza, pasta")
                }
            }
        }
    }
}
#endif
