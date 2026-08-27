//
//  ProductShopApp.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import SwiftUI

@main
struct ProductShopApp: App {
    
    @State private var favoritesStore = FavoritesStore()
    @State private var cartStore = CartStore()

    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(favoritesStore)
                .environment(cartStore)
        }
    }
}
