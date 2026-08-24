//
//  Endpoints.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var queryItems: [URLQueryItem]? {
        nil
    }
}


enum Endpoints: Endpoint {
    case categories
    case products(category: String?)

    var path: String {
        switch self {
        case .categories:
            return "products/category-list"

        case .products(let category):
            if let category, !category.isEmpty {
                return "products/category/\(category)"
            } else {
                return "products"
            }
        }
    }

    var method: HTTPMethod {
        switch self {
        case .categories, .products:
            return .get
        }
    }
}
