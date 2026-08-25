//
//  RootTabView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ProductsView()
            }
            .tabItem {
                Label("Home" , systemImage: "house")
            }
            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart")
            }
        }
    }
}

#Preview {
    RootTabView()
}
