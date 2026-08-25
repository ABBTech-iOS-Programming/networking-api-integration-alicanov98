//
//  ProductsDetailViewModel.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import Foundation
import Observation


@MainActor
@Observable
final class ProductsDetailViewModel {
    let product: Product
    
    private(set)  var quantity = 1
    
    init(product: Product, ) {
        self.product = product
    }
    
    var discountedPrice: Double {
            product.price * (1 - product.discountPercentage / 100)
        }

        var totalPrice: Double {
            discountedPrice * Double(quantity)
        }

        var formattedTotalPrice: String {
            String(format: "$%.2f", totalPrice)
        }

        var stockText: String {
            "In stock: \(product.stock)"
        }

        var canDecreaseQuantity: Bool {
            quantity > 1
        }

        var canIncreaseQuantity: Bool {
            quantity < product.stock
        }


        func increaseQuantity() {
            guard canIncreaseQuantity else {
                return
            }

            quantity += 1
        }

        func decreaseQuantity() {
            guard canDecreaseQuantity else {
                return
            }

            quantity -= 1
        }
    
}
