//
//  SelectedServiceView.swift
//  ShortURLBuilder
//
//  Created by Terry Tan on 28/09/2025.
//

import SwiftUI

struct SelectedServiceView: View {
    let service: URLService
    var onTapService: () -> Void

    var body: some View {
        ChipContainer {
            VStack(alignment: .leading, spacing: 12) {
                title

                Button {
                    onTapService()
                } label: {
                    HStack {
                        serviceIcon
                        serviceInfo
                        Spacer()
                        arrowIcon
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

    private var title: some View {
        Text("Service")
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.primary)
    }

    private var serviceIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(service.color)
                .frame(width: 40, height: 40)

            Text(service.icon)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
    }

    private var serviceInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(service.name)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text(service.domain)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    private var arrowIcon: some View {
        Image(systemName: "chevron.down")
            .foregroundColor(.secondary)
            .font(.system(size: 16))
    }
}

#Preview {
    SelectedServiceView(service: .bitly) {
        print("Tapped!")
    }
}
