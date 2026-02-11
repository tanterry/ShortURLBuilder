//
//  Provider+UI.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 11/02/2026.
//

import SwiftUI
import ShortURLBuilderProvider

extension Provider {
    var domain: String {
        switch self {
        case .bitly:
            return "bit.ly"
        case .cuttly:
            return "cutt.ly"
        }
    }

    var color: Color {
        switch self {
        case .bitly:
            return .orange
        case .cuttly:
            return .blue
        }
    }

    var icon: String {
        switch self {
        case .bitly:
            return "B"
        case .cuttly:
            return "C"
        }
    }
}
