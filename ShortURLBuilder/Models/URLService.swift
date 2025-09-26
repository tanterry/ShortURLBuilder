//
//  URLService.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import Foundation
import SwiftUI

struct URLService: Identifiable, Hashable {
    let id: String
    let name: String
    let domain: String
    let color: Color
    let icon: String
    let hasToken: Bool

    static let sampleServices = [
        bitly,
        URLService(id: "cuttly", name: "Cuttly", domain: "cutt.ly", color: .blue, icon: "C", hasToken: true),
        URLService(id: "tinyurl", name: "TinyURL", domain: "tinyurl.com", color: .green, icon: "T", hasToken: true),
        URLService(id: "shortio", name: "Short.io", domain: "short.io", color: .purple, icon: "S", hasToken: true),
        URLService(id: "rebrandly", name: "Rebrandly", domain: "rebrandly.com", color: .red, icon: "R", hasToken: true)
    ]

    static let bitly = URLService(
        id: "bitly",
        name: "Bitly",
        domain: "bit.ly",
        color: .orange,
        icon: "B",
        hasToken: true
    )
}
