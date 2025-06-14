//
//  ContentView.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 09/08/2024.
//

import ShortURLBuilderProvider
import SwiftData
import SwiftUI

@MainActor
struct ContentView: View {
    var providers = Provider.allCases
    
    @State var selected: ServiceModel?
    @State private var showingCredentials = false
    private var credentialsManager = CredentialsManager.shared

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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCredentials = true
                    } label: {
                        Image(systemName: "key.fill")
                    }
                }
            }
        }
        .sheet(item: $selected) {
            selected = nil
        } content: { item in
            URLSheetView(item: item)
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingCredentials) {
            CredentialsView()
        }
        .environmentObject(credentialsManager)
    }
}
