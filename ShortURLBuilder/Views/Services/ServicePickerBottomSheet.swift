//
//  ServicePickerBottomSheet.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI
import ShortURLBuilderProvider

struct ServicePickerBottomSheet: View {
    @Binding var selectedService: Provider?
    let availableServices: [Provider]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if availableServices.isEmpty {
                    // Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 56))
                            .foregroundColor(.secondary)
                            .padding(.top, 40)

                        VStack(spacing: 8) {
                            Text("No Services Available")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)

                            Text("Add API tokens to see available services")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Service List
                    List {
                        ForEach(availableServices, id: \.self) { service in
                            ServiceRow(
                                service: service,
                                isSelected: selectedService == service,
                                onTap: {
                                    selectedService = service
                                    dismiss()
                                }
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Choose Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.medium)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    ServicePickerBottomSheet(
        selectedService: .constant(.bitly),
        availableServices: Provider.allCases
    )
}
