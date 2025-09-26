//
//  ServiceSelectionSection.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI

struct ServiceSelectionSection: View {
    @Binding var selectedService: URLService?
    let availableServices: [URLService]
    @State private var showingServicePicker = false

    var body: some View {
        ChipContainer {
            VStack(alignment: .leading, spacing: 12) {
                Text("Service")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)

                Button(action: {
                    showingServicePicker = true
                }) {
                    HStack {
                        if let service = selectedService {
                            // Service Icon
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(service.color)
                                    .frame(width: 40, height: 40)

                                Text(service.icon)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            }

                            // Service Info
                            VStack(alignment: .leading, spacing: 2) {
                                Text(service.name)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)

                                Text(service.domain)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.down")
                                .foregroundColor(.secondary)
                                .font(.system(size: 16))
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .sheet(isPresented: $showingServicePicker) {
            ServicePickerBottomSheet(
                selectedService: $selectedService,
                availableServices: availableServices
            )
        }
    }
}

#Preview {
    ServiceSelectionSection(
        selectedService: .constant(
            URLService(
                id: "bitly",
                name: "Bitly",
                domain: "bit.ly",
                color: .orange,
                icon: "B",
                hasToken: true
            )
        ),
        availableServices: URLService.sampleServices
    )
}
