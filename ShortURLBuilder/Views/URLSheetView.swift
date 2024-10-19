//
//  URLSheetView.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 16/08/2024.
//

import SwiftUI
import ShortURLBuilderProvider

struct URLSheetView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject private var item: ServiceModel

    @State private var url: String = ""
    @State private var generatedLink = ""
    @State private var errorMessage: String?
    @State private var isCopied = false
    @FocusState private var textfieldFocused: Bool

    init(item: ServiceModel) {
        self.item = item
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if !generatedLink.isEmpty {
                    generatedLinkView(generatedLink)
                }
                if let errorMessage {
                    errorView(errorMessage)
                }
                textField
                generateButton
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(item.name)
            .onChange(of: url) {
                if errorMessage != nil {
                    errorMessage = nil
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    closeButton
                }
            }
        }
    }

    private func generatedLinkView(_ link: String) -> some View {
        HStack {
            Text(link)

            Button {
                UIPasteboard.general.string = link

                withAnimation {
                    isCopied = true
                } completion: {
                    withAnimation {
                        isCopied = false
                    }
                }
            } label: {
                if isCopied {
                    Image(systemName: "checkmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "doc.on.doc")
                        .renderingMode(.template)
                        .foregroundStyle(.foreground)
                }
            }
            .frame(height: 16)
            .disabled(isCopied)
        }
    }

    private var textField: some View {
        TextField("Enter the URL:", text: $url)
            .focused($textfieldFocused)
            .keyboardType(.URL)
            .textFieldStyle(.roundedBorder)
    }

    private var generateButton: some View {
        Button("Shorten the link") {
            Task {
                do {
                    generatedLink = try await item.shorten(url: url)
                } catch {
                    errorMessage = "URL is invalid."
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 3))
        .tint(.orange)
    }

    private func errorView(_ message: String) -> Text {
        Text(message)
            .foregroundColor(.red)
    }

    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .tint(.primary)
                .foregroundStyle(.gray)
        }
    }
}
