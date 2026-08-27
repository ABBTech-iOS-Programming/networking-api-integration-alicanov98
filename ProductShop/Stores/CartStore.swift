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

    private enum Keys {
        static let cartItems = "cart_items"
    }

    @ObservationIgnored
    private let userDefaults: UserDefaults

    private(set) var items: [CartItem] = [] {
        didSet {
            saveItems()
        }
    }

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

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.items = Self.loadItems(from: userDefaults)
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
            items.append(
                CartItem(
                    product: product,
                    quantity: quantity
                )
            )
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
        } else {
            remove(product)
        }
    }

    func remove(_ product: Product) {
        items.removeAll {
            $0.product.id == product.id
        }
    }

    func contains(_ product: Product) -> Bool {
        items.contains {
            $0.product.id == product.id
        }
    }

    private func saveItems() {
        do {
            let data = try JSONEncoder().encode(items)
            userDefaults.set(data, forKey: Keys.cartItems)
        } catch {
            print(error.localizedDescription)
        }
    }

    private static func loadItems(
        from userDefaults: UserDefaults
    ) -> [CartItem] {
        guard let data = userDefaults.data(forKey: Keys.cartItems) else {
            return []
        }

        do {
            return try JSONDecoder().decode([CartItem].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
