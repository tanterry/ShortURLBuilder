//
//  BitlyService.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 12/08/2024.
//

import Foundation
import ShortURLNetwork

public final class BitlyService: NSObject, ShortenLinkService {
    private let networker = ShortenLinkNetworker()

    override public init() {}

    public func shorten(url: String) async throws -> String {
        let response = try await networker.requestDecodable(
            BitlyResponse.self,
            endpoint: BitlyEndpoint.shorten(url),
            decoder: JSONDecoder()
        )

        return response.link
    }
}
