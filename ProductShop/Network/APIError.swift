//
//  APIError.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    case unknown(Error)
    
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL duzgun deyil"
            
        case .invalidResponse:
            return "Server cavabi duzgun deyil"
        
        case .serverError(let statusCode):
            return "Server xetasi: \(statusCode)"
            
        case .decodingError(let error):
            return "Melumatlari oxumaq mumkun olmadi \(error.localizedDescription)"
            
        case .networkError(let error):
                    return "Şəbəkə xətası: \(error.localizedDescription)"
        
        case .unknown(let error):
            return error.localizedDescription
        }
    }
    
}
