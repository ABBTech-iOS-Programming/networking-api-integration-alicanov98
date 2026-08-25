//
//  FavoritesView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FavoritesStore.self)
    private var favoritesStore
    
    var body: some View {
        ScrollView {
            if favoritesStore.products.isEmpty {
                ContentUnavailableView("No Favorites",
                                       systemImage: "heart",
                                       description: Text("Products you favorite will appear here."))
            }else {
                LazyVStack(spacing:12){
                    ForEach(favoritesStore.products) { product in
                    ProductCardView(product: product)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.large)
    }
}

