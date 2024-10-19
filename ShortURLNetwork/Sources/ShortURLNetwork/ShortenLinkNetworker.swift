//
//  ShortenLinkNetworker.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 11/08/2024.
//

import Foundation

public protocol ShortenLinkNetworkerProtocol {
    func requestData(_ request: URLRequest) async throws -> Data

    func requestDecodable<T: Decodable>(
        _ type: T.Type,
        endpoint: any BaseEndpoint,
        decoder: JSONDecoder
    ) async throws -> T
}

public extension ShortenLinkNetworkerProtocol {
    func requestDecodable<T: Decodable>(
        _ type: T.Type,
        endpoint: any BaseEndpoint
    ) async throws -> T {
        try await requestDecodable(
            type,
            endpoint: endpoint,
            decoder: JSONDecoder()
        )
    }
}

public actor ShortenLinkNetworker: ShortenLinkNetworkerProtocol {
    public init() {}

    public func requestData(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return data
    }

    public func requestDecodable<T: Decodable & Sendable>(
        _ type: T.Type,
        endpoint: any BaseEndpoint,
        decoder: JSONDecoder = .init()
    ) async throws -> T {
        let urlRequest = try buildRequest(from: endpoint)
        let data = try await requestData(urlRequest)
        return try decoder.decode(T.self, from: data)
    }

    private func buildRequest(from endpoint: any BaseEndpoint) throws -> URLRequest {
        var component = URLComponents(string: endpoint.baseURL)
        component?.path = endpoint.path

        guard let url = component?.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body

        for (key, value) in endpoint.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }
}
