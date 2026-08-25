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

    private enum Keys {
        static let favoriteProducts = "favorite_products"
    }

    @ObservationIgnored
    private let userDefaults: UserDefaults

    private(set) var products: [Product] = [] {
        didSet {
            saveProducts()
        }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.products = Self.loadProducts(from: userDefaults)
    }

    func toggle(_ product: Product) {
        if contains(product) {
            remove(product)
        } else {
            products.append(product)
        }
    }

    func contains(_ product: Product) -> Bool {
        products.contains {
            $0.id == product.id
        }
    }

    func remove(_ product: Product) {
        products.removeAll {
            $0.id == product.id
        }
    }

    private func saveProducts() {
        do {
            let data = try JSONEncoder().encode(products)
            userDefaults.set(data, forKey: Keys.favoriteProducts)
        } catch {
            print(error.localizedDescription)
        }
    }

    private static func loadProducts(
        from userDefaults: UserDefaults
    ) -> [Product] {
        guard let data = userDefaults.data(
            forKey: Keys.favoriteProducts
        ) else {
            return []
        }

        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
