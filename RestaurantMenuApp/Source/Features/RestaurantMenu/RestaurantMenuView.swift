//
//  RestaurantMenuView.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import SwiftUI

struct RestaurantMenuView: View {
    
    @ObservedObject var presenter: RestaurantMenuPresenter
    
    var body: some View {
        VStack {
            RestaurantHeader(
                title: presenter.restaurant.restaurantName,
                subtitle: "MENU")

            MenuCategorySelector(
                tabs: presenter.categories,
                selected: $presenter.selectedCategory)
            
            ScrollView {
                LazyVStack {
                    switch presenter.state {
                    case .loading:
                        ProgressView("Loading menu")
                            .id("loadingView")
                    case .loaded:
                        menuItemsList
                            .id("menuItemsView")
                    case .empty:
                        MessageView(content: "Sorry, we didn't find menu items")
                            .id("emptyMessageView")
                    case .error:
                        MessageView(content: "An error ocurred, try again later.")
                            .id("errorMessageView")
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            presenter.load()
        }
    }
    
    var menuItemsList: some View {
        ForEach(presenter.list, id: \.itemID) { item in
            MenuItemView(
                name: item.menuItemName,
                description: item.menuItemDescription,
                price: item.price)
        }
    }
}

struct RestaurantHeader: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(Font.montserratRegular(size: 16))
                .padding(.bottom, 10)
            
            Rectangle()
                .fill(Color.customLightGray2)
                .frame(height: 0.5)
            
            Text(subtitle)
                .font(Font.montserratRegular(size: 16))
                .padding(.top, 22)
                .padding(.bottom, 22)
        }
    }
}

struct MenuItemView: View {
    
    var name: String
    var description: String
    var price: String
    
    var body: some View {
        VStack {
            
            Text(name)
                .font(Font.playfairDisplayRegular(size: 24))
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Text(description)
                .font(Font.playfairDisplayRegular(size: 15))
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
                .padding(.horizontal, 40)
            
            Text(price)
                .font(Font.montserratRegular(size: 11))
            
            Rectangle()
                .fill(Color.customLightGray2)
                .frame(height: 0.5)
                .padding(.horizontal, 44)
        }
        .padding(.horizontal, 16)
    }
}

struct MenuCategorySelector: View {
    
    var tabs: [String]
    
    @Binding var selected: String
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { item in
                        VStack {
                            Rectangle()
                                .fill(Color.customLightGray2)
                                .frame(height: 0.5)
                            
                            Button(item.uppercased()) {
                                selected = item
                            }
                            .frame(height: 30)
                            .font(Font.montserratRegular(size: 12))
                            .foregroundColor(
                                selected.lowercased() == item.lowercased()
                                ? Color.customBlack
                                : Color.customLightGray2
                            )
                            .padding(.horizontal, 16)
                            .id(item)
                            
                            Rectangle()
                                .fill(
                                    selected.lowercased() == item.lowercased()
                                    ? Color.customBlack
                                    : Color.customLightGray2
                                )
                                .frame(height: 0.5)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 15)
    }
}

#if DEBUG
struct RestaurantMenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            RestaurantHeader(
                title: "Mona lisa pasta & pizza",
                subtitle: "MENU")
            
            MenuCategorySelector(
                tabs: ["Salads", "Small plates", "Dishes", "Hamburguers", "Pizzas", "Wings"],
                selected: .constant("Salads"))
            
            MenuItemView(
                name: "Pear salad",
                description: "Reid’s Orchard Pears / Bitter Greens / Granola / Firefly Farms Black and Blue / Pine Nut Vinaigrette",
                price: "$ 11.50")
            
            MenuItemView(
                name: "Pear salad",
                description: "Reid’s Orchard Pears / Bitter Greens / Granola / Firefly Farms Black and Blue / Pine Nut Vinaigrette",
                price: "$ 11.50")
            
            Spacer()
        }
    }
}
#endif
