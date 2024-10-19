//
//  BaseEndpoint.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 18/08/2024.
//

import Foundation

public protocol BaseEndpoint: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var query: [URLQueryItem]? { get }
    var body: Data? { get }
}
