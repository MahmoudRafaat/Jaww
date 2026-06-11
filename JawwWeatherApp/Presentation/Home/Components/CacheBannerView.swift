//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//


import SwiftUI

struct CacheBannerView: View {
    let lastUpdated: Date?

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 13))

            if let date = lastUpdated {
                Text("Offline · Last updated \(date.formatted(.relative(presentation: .named)))")
                    .font(.system(size: 13))
            } else {
                Text("Offline · Showing cached data")
                    .font(.system(size: 13))
            }

            Spacer()
        }
        .foregroundColor(.orange)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.orange.opacity(0.12))
    }
}
