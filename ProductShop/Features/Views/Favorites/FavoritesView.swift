//
//  FavoritesView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FavoritesStore.self) private var favoritesStore
    @Environment(CartStore.self) private var cartStore
    
    
    var body: some View {
        ScrollView {
            if favoritesStore.products.isEmpty {
                    ContentUnavailableView("No Favorites",
                   systemImage: "heart",
                   description: Text("Products you favorite will appear here."))
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 500)
                
              
            }else {
                LazyVStack(spacing:12){
                    ForEach(favoritesStore.products) { product in
                        NavigationLink {
                              ProductsDetailView(product: product)
                        } label: {
                            FavoriteItemView(
                                product: product,
                                addToCart: {
                                    cartStore.add(product: product)
                                },
                                removeFromFavorite: {
                                    favoritesStore.remove(product)
                                }
                            )
                        
                        }
                    }
                }
                .padding()
            }
        }
        .background(.primaryOrange.opacity(0.1))
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.large)
    }
}

