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
    struct AlertInfo {
        let title: String
        let message: String
    }

    private var providers = Provider.allCases

    @State private var isPresentedAlert = false
    @State private var alertInfo: AlertInfo?

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
            .alert(isPresented: $isPresentedAlert) {
                Alert(
                    title: Text(alertInfo?.title ?? ""),
                    message: Text(alertInfo?.message ?? ""),
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

                alertInfo = AlertInfo(title: "URL is generated & copied!", message: generatedLink)
            } catch {
                alertInfo = AlertInfo(title: "Something went wrong", message: error.localizedDescription)
            }

            isPresentedAlert = true
        }
    }
}
