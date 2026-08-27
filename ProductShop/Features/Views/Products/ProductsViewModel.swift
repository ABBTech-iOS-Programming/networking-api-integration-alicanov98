//
//  ProductsViewModel.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import Foundation
import Observation


@MainActor
@Observable
final class ProductsViewModel {

     private(set) var products: [Product] = []
     private(set) var categories: [String] = []
     private(set) var isLoading = false
     var errorMessage: String?
     private(set) var selectedCategory: String? = "All"
     private let apiService: any APIServiceProtocol
     var searchText = ""
    
    init(apiService: any APIServiceProtocol) {
        self.apiService = apiService
    }

    var filteredProducts: [Product] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return products
        }

        return products.filter { product in
            product.title.localizedCaseInsensitiveContains(query) ||
            product.category.localizedCaseInsensitiveContains(query) ||
            product.brand?.localizedCaseInsensitiveContains(query) == true
        }
    }
    
    
    func refresh() async {
        await fetchProducts(
            category: selectedCategory == "All"
            ? nil
            : selectedCategory
        )
    }
    
    func fetchCategories() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let response: [String] = try await apiService.request(
                endpoint: Endpoints.categories,
                responseType: [String].self
            )

            
            categories = ["All"] + response
            selectedCategory = "All"
            await fetchProducts(category: nil)
        } catch {
            handle(error)
        }
    }

    func fetchProducts(category: String?) async {
        selectedCategory = category ?? "All"
        
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let response: ProductsResponse = try await apiService.request(
                endpoint: Endpoints.products(category: category),
                responseType: ProductsResponse.self
            )

            products = response.products
        } catch {
            handle(error)
        }
    }

    private func handle(_ error: Error) {
        errorMessage = error.localizedDescription
    }
}
