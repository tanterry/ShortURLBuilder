//
//  HomeView.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

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
                        hasNoTokens: selectedService == nil,
                        onGeneratePressed: generateShortURL
                    )

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
