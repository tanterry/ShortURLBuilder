//
//  BitlyEndpoint.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 18/08/2024.
//

import Foundation
import ShortURLNetwork
import CredentialsManager

enum BitlyEndpoint: BaseEndpoint {
    case shorten(String)

    var baseURL: String { "https://api-ssl.bitly.com" }

    var path: String { "/v4/shorten" }

    var method: HTTPMethod { .post }

    var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }

    var query: [URLQueryItem]? { nil }

    var body: Data? {
        switch self {
        case let .shorten(link):
            try? JSONEncoder().encode([
                "long_url": link.trimmingCharacters(in: .whitespacesAndNewlines),
                "domain": "bit.ly"
            ])
        }
    }

    private var token: String { Config.bitlyToken }
}
