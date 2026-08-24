//
//  APIService.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import Foundation

protocol APIServiceProtocol {
    func request<T: Decodable>(
        endpoint: any Endpoint,
        responseType: T.Type
    ) async throws -> T
}

final class APIService: APIServiceProtocol {

    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        baseURL: URL = URL(string: "https://dummyjson.com")!,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(
        endpoint: any Endpoint,
        responseType: T.Type
    ) async throws -> T {
        let request = try makeRequest(for: endpoint)

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw APIError.networkError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(
                statusCode: httpResponse.statusCode
            )
        }

        do {
            return try decoder.decode(responseType, from: data)
        } catch {
            print("Decoding error:", error)
            throw APIError.decodingError(error)
        }
    }

    private func makeRequest(
        for endpoint: any Endpoint
    ) throws -> URLRequest {
        let endpointURL = baseURL
            .appendingPathComponent(endpoint.path)

        guard var components = URLComponents(
            url: endpointURL,
            resolvingAgainstBaseURL: false
        ) else {
            throw APIError.invalidURL
        }

        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        return request
    }
}
