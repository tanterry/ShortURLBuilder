//
//  ShortenLinkService.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 09/08/2024.
//

import Foundation

public protocol ShortenLinkService: Sendable {
    func shorten(url: String) async throws -> String
}
