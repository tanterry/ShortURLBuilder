//
//  NoTokenView.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

struct NoTokenView: View {
    var onAddTokensPressed: () -> Void

    var body: some View {
        ChipContainer {
            VStack(spacing: 24) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color(.systemGray6))
                        .frame(width: 64, height: 64)

                    Image(systemName: "gearshape")
                        .font(.system(size: 28))
                        .foregroundColor(.secondary)
                }

                // Content
                VStack(spacing: 16) {
                    Text("No Services Configured")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)

                    Text("To start shortening URLs, you need to add API tokens for at least one service.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Action Button
                Button(action: onAddTokensPressed) {
                    Text("Add API Tokens")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical, 8)
        }
        .overlay(
            // Dashed border overlay
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color(.systemGray4),
                    style: StrokeStyle(lineWidth: 2, dash: [8, 4])
                )
                .padding(1)
        )
    }
}

#Preview {
    NoTokenView { print("It is tapped!") }
}
