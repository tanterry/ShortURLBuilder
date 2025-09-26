//
//  ChipContainer.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

struct ChipContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 16) {
            content
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
    }
}

#Preview {
    ChipContainer {
        Text("Hello, world!")
    }
}
