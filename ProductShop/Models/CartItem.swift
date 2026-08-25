//
//  CartItem.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import Foundation

extension Product {
    var discountedPrice: Double {
        price * (1 - discountPercentage / 100)
    }
}

struct CartItem: Identifiable {
    let product: Product
    var quantity: Int
    
    var id: Int {
        product.id
    }
    
    var totalPrice: Double {
        product.discountedPrice  * Double(quantity)
    }
}
