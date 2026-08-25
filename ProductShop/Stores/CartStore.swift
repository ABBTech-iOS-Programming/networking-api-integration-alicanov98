//
//  CartStore.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import Foundation
import Observation

@Observable
final class CartStore {
    
    
    
    private(set) var items: [CartItem] = []
    
    var totalQuantity: Int {
            items.reduce(0) { result, item in
                result + item.quantity
            }
    }
    
    var totalPrice: Double {
            items.reduce(0) { result, item in
                result + item.totalPrice
            }
        }
    
    func add(product: Product, quantity: Int = 1) {
        guard quantity > 0 else {
            return
        }
        
        if let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    func increaseQuantity(for product: Product) {
        guard let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) else {
           return
        }
        items[index].quantity += 1
    }
    
    func decreaseQuantity(for product: Product) {
        guard let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) else {
            return
        }
        
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        }
    }
    
    func remove(_ product: Product) {
        items.removeAll {
            $0.product.id == product.id
        }
    }
    
    func contains(_ product:Product) -> Bool {
        items.contains {
            $0.product.id == product.id
        }
    }
}
