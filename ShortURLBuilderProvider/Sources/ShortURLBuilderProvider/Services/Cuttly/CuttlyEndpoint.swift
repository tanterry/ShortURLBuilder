//
//  CuttlyEndpoint.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 18/08/2024.
//

import Foundation
import ShortURLNetwork

enum CuttlyEndpoint: BaseEndpoint {
    case short(String, alias: String?)

    var baseURL: String { "https://cutt.ly/api/api.php" }

    var path: String { "" }

    var method: HTTPMethod { .get }

    var headers: [String: String] { [:] }

    var query: [URLQueryItem]? {
        switch self {
        case let .short(link, alias):
            let quotedURL = link
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let queryItems = [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "short", value: quotedURL),
                URLQueryItem(name: "name", value: alias)
            ]

            return queryItems
        }
    }

    var body: Data? { nil }

    private var apiKey: String { Config.cuttlyApiKey }
}
