//
//  URLInputSection.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

struct URLInputSection: View {
    @Binding var urlText: String
    @Binding var hasNoTokens: Bool

    var onGeneratePressed: () -> Void

    var body: some View {
        ChipContainer {
            // URL Input Field
            inputView

            // Generate Button
            generateButton
                .disabled(hasNoTokens)
        }
    }

    private var inputView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Enter URL to shorten")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)

            HStack {
                TextField("https://example.com/your-long-url", text: $urlText)
                    .font(.body)
                    .foregroundColor(hasNoTokens ? .secondary : .primary)
                    .disabled(hasNoTokens)

                Image(systemName: "link")
                    .foregroundColor(hasNoTokens ? .secondary.opacity(0.5) : .secondary)
                    .font(.system(size: 20))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(hasNoTokens ? Color(.systemGray6) : Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(hasNoTokens ? Color(.systemGray4) : Color(.systemGray4), lineWidth: 1)
                    )
            )
        }
    }

    private var generateButton: some View {
        Button(action: onGeneratePressed) {
            HStack {
                Text("Generate Short URL")
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(hasNoTokens ? Color(.systemGray4) : Color.blue)
            )
            .foregroundColor(hasNoTokens ? .secondary : .white)
        }
        .disabled(hasNoTokens)
    }
}

#Preview {
    URLInputSection(
        urlText: .constant(""),
        hasNoTokens: .constant(false),
        onGeneratePressed: { print("Generate pressed") }
    )
}
