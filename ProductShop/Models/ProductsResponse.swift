//
//  Product.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import Foundation

// MARK: - ProductsResponse

struct ProductsResponse: Codable  {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

// MARK: - Product

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String
}



// MARK: - Review

struct Review: Codable, Identifiable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String

    var id: String {
        reviewerEmail + date
    }
}
