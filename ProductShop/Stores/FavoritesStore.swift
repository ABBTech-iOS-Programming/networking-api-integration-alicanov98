//
//  FavoritesStore.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import Foundation
import Observation

@Observable
final class FavoritesStore {
    private(set) var products: [Product] = []
    
    func toggle(_ product: Product) {
        if contains(product){
            remove(product)
        } else {
            products.append(product)
        }
    }
    
    func contains(_ product: Product) -> Bool {
        products.contains { $0.id == product.id}
    }
    
    func remove(_ product: Product){
        products.removeAll { $0.id == product.id }
    }
}
