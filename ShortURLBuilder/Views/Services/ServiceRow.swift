//
//  ServiceRow.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 26/09/2025.
//

import SwiftUI
import ShortURLBuilderProvider

struct ServiceRow: View {
    let service: Provider
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
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
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                // Selection Indicator
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ServiceRow(
        service: .bitly,
        isSelected: true,
        onTap: { print("It is tapped!") }
    )
}
