//
//  navigationBar.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import SwiftUI

struct navigationBar: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 24, weight: .medium))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(themeManager.primaryTextColor)
                    .padding(8)
            }
            .buttonStyle(.plain)

            NavigationLink(destination: Text("Favorites Page Destination")) {
                Image(systemName: "star")
                    .font(.system(size: 24, weight: .medium))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(themeManager.primaryTextColor)
                    .padding(8)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
        .padding(.top, 60)
    }
}


