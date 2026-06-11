//
//  navigationBar.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import SwiftUI

struct navigationBar: View {
    @EnvironmentObject var themeManager: ThemeManager
    let city :WeatherResponse
    init(city: WeatherResponse) {
        self.city = city
    }
    var body: some View {
        HStack(alignment: .center) {
            NavigationLink(destination: FavoritesView()) {
                Image(systemName: "star")
                    .font(.system(size: 24, weight: .medium))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(themeManager.primaryTextColor)
                    .padding(8)
            }
            .buttonStyle(.plain)
            Spacer()

            VStack(spacing: 2) {
                Text(city.location.name)
                    .font(.system(size: 37, weight: .regular))
                    .foregroundColor(themeManager.primaryTextColor)
                
            }
            Spacer()

            NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
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


