//
//  ShortURLBuilderActionView.swift
//  ShortURLBuilderAction
//
//  Created by Terry Tan on 19/10/2024.
//

import SwiftUI
import ShortURLNetwork
import ShortURLBuilderProvider

struct ShortURLBuilderActionView: View {
    private var providers = Provider.allCases

    @State private var isCopied = false
    @State private var copiedURLString: String?

    @State private var isErrorPresented = false
    @State private var errorMessage: String?

    private let url: URL
    private let close: () -> Void

    init(url: URL, close: @escaping () -> Void) {
        self.url = url
        self.close = close
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(providers, id: \.name) { provider in
                    Button {
                        generateURL(from: provider.viewModel)
                    } label: {
                        Text(provider.name)
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                }
            }
            .alert(isPresented: $isCopied) {
                Alert(
                    title: Text("URL is generated & copied!"),
                    message: Text(copiedURLString ?? ""),
                    dismissButton: .cancel(Text("Done"))
                )
            }
            .alert(isPresented: $isErrorPresented) {
                Alert(
                    title: Text("Something went wrong"),
                    message: Text(errorMessage ?? ""),
                    dismissButton: .cancel(Text("Done"))
                )
            }
            .navigationTitle("Choose a provicer")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        close()
                    }
                }
            }
        }
    }

    private func generateURL(from viewModel: ServiceModel) {
        Task {
            do {
                let generatedLink = try await viewModel.shorten(url: url.absoluteString)
                UIPasteboard.general.string = generatedLink

                copiedURLString = generatedLink
                isCopied = true
            } catch {
                isErrorPresented = true
                errorMessage = error.localizedDescription
            }
        }
    }
}
