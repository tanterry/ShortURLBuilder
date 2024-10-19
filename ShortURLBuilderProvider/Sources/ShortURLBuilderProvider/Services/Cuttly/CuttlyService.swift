//
//  CuttlyService.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 13/08/2024.
//

import Foundation
import ShortURLNetwork

public final class CuttlyService: NSObject, ShortenLinkService {
    private let networker = ShortenLinkNetworker()
    private let endpoint = "" // I do not know
    private let token = ""

    override public init() {}

    public func shorten(url: String) async throws -> String {
        let name = String((0 ..< 7)
            .compactMap { _ in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement() })

        let response = try await networker.requestDecodable(
            CuttlyResponse.self,
            endpoint: CuttlyEndpoint.short(url, alias: name),
            decoder: JSONDecoder()
        )

        return response.url
    }
}
