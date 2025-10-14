//
//  HomeView.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI
import ShortURLBuilderProvider
import CredentialsManager

struct HomeView: View {
    @State private var urlText = ""
    @State private var shortenURL: String?
    @State private var selectedService: URLService?
    @State private var availableServices: [URLService] = []
    @State private var showingServicePicker = false
    @State private var showingCredentials = false
    @StateObject private var credentialsManager = CredentialsManager.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    URLGenerationSection(
                        urlText: $urlText,
                        shortenURL: $shortenURL,
                        service: selectedService
                    ) {
                        Task {
                            await generateShortURL()
                        }
                    }

                    if let selectedService {
                        SelectedServiceView(service: selectedService) {
                            showingServicePicker = true
                        }
                    } else {
                        NoTokenView {
                            showingCredentials = true
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("URL Shortener")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCredentials = true
                    } label: {
                        Image(systemName: "key.fill")
                    }
                }
            }
            .sheet(isPresented: $showingServicePicker) {
                ServicePickerBottomSheet(
                    selectedService: $selectedService,
                    availableServices: availableServices
                )
            }
            .sheet(isPresented: $showingCredentials) {
                CredentialsView()
            }
            .task(id: credentialsManager.lastUpdated) {
                reloadServices()
            }
            .environmentObject(credentialsManager)
            .onAppear {
                reloadServices()
            }
        }
    }

    private func reloadServices() {
        availableServices = Provider.allCases.reduce(into: [URLService]()) { result, provider in
            switch provider {
            case .bitly:
                let token = credentialsManager.retrieve(for: .bitlyToken)
                if !token.isEmpty {
                    result.append(.bitly)
                }
            case .cuttly:
                let token = credentialsManager.retrieve(for: .cuttlyApiKey)
                if !token.isEmpty {
                    result.append(.cuttly)
                }
            }
        }
        selectedService = availableServices.first
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

                self.shortenURL = shortenURL
            } catch {
                print("Failed to generate short URL: \(error.localizedDescription)")
            }
        }
    }

    private func getShortenService(for selectedService: URLService) -> ShortenLinkService {
        switch selectedService.id {
        case .bitly: BitlyService()
        case .cuttly: CuttlyService()
        }
    }
}

#Preview {
    HomeView()
}
