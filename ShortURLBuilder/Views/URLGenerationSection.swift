//
//  URLGenerationSection.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 30/09/2025.
//

import SwiftUI

struct URLGenerationSection: View {
    @Binding var urlText: String
    @Binding var shortenURL: String?

    var service: URLService?
    var hasNoTokens: Bool { service == nil }

    var onGeneratePressed: () -> Void

    var body: some View {
        ChipContainer {
            if shortenURL == nil {
                inputView

                actionButton(
                    text: "Generate Short URL",
                    disabled: hasNoTokens,
                    action: onGeneratePressed
                )
            } else {
                resultHeader
                originalInputView
                generatedURLView

                actionButton(text: "Create New Link") {
                    resetInput()
                }
            }
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

    private func actionButton(
        text: String,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(disabled ? Color(.systemGray4) : Color.blue)
            )
            .foregroundColor(disabled ? .secondary : .white)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(disabled)
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
        .buttonStyle(PlainButtonStyle())
        .disabled(hasNoTokens)
    }

    private var resultHeader: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 20))

            Text("Link Created!")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Spacer()
        }
    }

    private var originalInputView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Original URL")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.gray)

            HStack {
                TextField("https://example.com/your-long-url", text: $urlText)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            )
        }
    }

    private var generatedURLView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Short URL")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)

                Spacer()

                if let service {
                    Text("via \(service.name)")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(.purple)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(
                            Capsule()
                                .fill(.purple.opacity(0.1))
                        )
                }
            }

            HStack {
                TextField("https://example.com/your-long-url", text: $urlText)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                Color.blue.opacity(0.3),
                                lineWidth: 2
                            )
                    )
            )
        }
    }

    private func resetInput() {
        urlText = ""
        shortenURL = nil
    }
}

#Preview {
    @Previewable @State var shortenURL: String?

    URLGenerationSection(
        urlText: .constant("https://www.example.com"),
        shortenURL: $shortenURL,
        service: .bitly
    ) {
        if shortenURL == nil {
            shortenURL = "https//bitly.com/lalala"
        } else {
            shortenURL = nil
        }
    }
}
