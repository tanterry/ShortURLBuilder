//
//  ServiceSelectionSection.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

struct ServiceSelectionSection: View {
    @Binding var selectedService: URLService?
    @Binding var showingServicePicker: Bool
    let availableServices: [URLService]

    var body: some View {
        if let selectedService {
            SelectedServiceView(service: selectedService) {
                showingServicePicker = true
            }
        } else {
            NoTokenView {
                print("Should add a token available")
            }
        }
    }
}

#Preview {
    ServiceSelectionSection(
        selectedService: .constant(.bitly),
        showingServicePicker: .constant(false),
        availableServices: URLService.sampleServices
    )
}
