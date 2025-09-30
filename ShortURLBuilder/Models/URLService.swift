//
//  URLService.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import Foundation
import SwiftUI
import ShortURLBuilderProvider

struct URLService: Identifiable, Hashable {
    let id: Provider
    let name: String
    let domain: String
    let color: Color
    let icon: String
    let hasToken: Bool

    static let sampleServices = [
        bitly,
        cuttly
    ]

    static let bitly = URLService(
        id: .bitly,
        name: "Bitly",
        domain: "bit.ly",
        color: .orange,
        icon: "B",
        hasToken: true
    )

    static let cuttly = URLService(
        id: .cuttly,
        name: "Cuttly",
        domain: "cutt.ly",
        color: .blue,
        icon: "C",
        hasToken: true
    )
}
