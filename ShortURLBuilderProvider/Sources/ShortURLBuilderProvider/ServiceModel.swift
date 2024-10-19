//
//  ServiceModel.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 12/08/2024.
//

import Foundation
import Combine
import ShortURLNetwork

@MainActor
public enum Provider: String, CaseIterable {
    case bitly = "Bitly"
    case cuttly = "Cuttly"

    public var name: String {
        rawValue
    }

    public var viewModel: ServiceModel {
        switch self {
        case .bitly:
            ServiceModel(name: name, service: BitlyService())
        case .cuttly:
            ServiceModel(name: name, service: CuttlyService())
        }
    }
}

@MainActor
public final class ServiceModel: Identifiable, ObservableObject {
    public let name: String

    @Published var link: String?

    private let service: ShortenLinkService

    public init(name: String, service: ShortenLinkService) {
        self.name = name
        self.service = service
    }

    public func shorten(url: String) async throws -> String {
        try await service.shorten(url: url)
    }
}
