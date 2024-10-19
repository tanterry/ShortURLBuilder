//
//  ContentView.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 09/08/2024.
//

import SwiftUI
import SwiftData
import ShortURLBuilderProvider

@MainActor
struct ContentView: View {
    var providers = Provider.allCases

    @State var selected: ServiceModel?

    var body: some View {
        NavigationView {
            List {
                ForEach(providers, id: \.name) { provider in
                    Button {
                        selected = provider.viewModel
                    } label: {
                        Text(provider.name)
                            .font(.title3)
                            .foregroundStyle(.pink)
                    }
                }
            }
            .navigationTitle("Shorten your link")
        }
        .sheet(item: $selected) {
            selected = nil
        } content: { item in
            URLSheetView(item: item)
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    ContentView()
}
