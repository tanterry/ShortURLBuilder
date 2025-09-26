//
//  HomeView.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var urlText = ""
    @State private var hasNoTokens = false
    @State private var selectedService = URLService.sampleServices.first
    @State private var availableServices = URLService.sampleServices

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    URLInputSection(
                        urlText: $urlText,
                        hasNoTokens: $hasNoTokens,
                        onGeneratePressed: generateShortURL
                    )

                    if !hasNoTokens {
                        ServiceSelectionSection(
                            selectedService: $selectedService,
                            availableServices: availableServices
                        )
                    }

                    // Toggle for testing
                    Toggle("No Tokens Available", isOn: $hasNoTokens)
                        .padding(.horizontal, 24)
                }
                .padding(.horizontal, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("URL Shortener")
        }
    }

    private func generateShortURL() {
        print("Generating short URL for: \(urlText)")
        if let service = selectedService {
            print("Using service: \(service.name)")
        }
    }
}

#Preview {
    HomeView()
}
