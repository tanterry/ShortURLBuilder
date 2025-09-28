//
//  HomeView.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI
import ShortURLBuilderProvider

struct HomeView: View {
    @State private var urlText = ""
    @State private var selectedService = URLService.sampleServices.first
    @State private var availableServices = URLService.sampleServices
    @State private var showingServicePicker = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    URLInputSection(
                        urlText: $urlText,
                        hasNoTokens: selectedService == nil
                    ) {
                        Task {
                            await generateShortURL()
                        }
                    }

                    ServiceSelectionSection(
                        selectedService: $selectedService,
                        showingServicePicker: $showingServicePicker,
                        availableServices: availableServices
                    )

                    // Toggle for testing
                    Toggle(
                        "No Tokens Available",
                        isOn: Binding(get: {
                            selectedService != nil
                        }, set: { value in
                            value ? (selectedService = URLService.sampleServices.first) : (selectedService = nil)
                        })
                    )
                    .padding(.horizontal, 24)
                }
                .padding(.horizontal, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("URL Shortener")
            .sheet(isPresented: $showingServicePicker) {
                ServicePickerBottomSheet(
                    selectedService: $selectedService,
                    availableServices: availableServices
                )
            }
        }
    }

    @MainActor
    private func generateShortURL() async {
        print("Generating short URL for: \(urlText)")
        if let service = selectedService {
            print("Using service: \(service.name)")
            do {
                let shortenService = getShortenService(for: service)
                let shortenURL = try await shortenService.shorten(url: urlText)
                print("Successfully generated short URL: \(shortenURL)")
            } catch {
                print("Failed to generate short URL: \(error.localizedDescription)")
            }
        }
    }

    private func getShortenService(for selectedService: URLService) -> ShortenLinkService {
        switch selectedService.id {
        case .bitly: BitlyService()
        case .cuttly: CuttlyService()
        default:
            fatalError("Unsupported service: \(selectedService.id)")
        }
    }
}

#Preview {
    HomeView()
}
