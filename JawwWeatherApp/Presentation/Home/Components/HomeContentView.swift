//
//  HomeContentView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        if viewModel.isLocationDenied {
            LocationDeniedView()
        } else if let weatherData = viewModel.weatherResponse {
            if viewModel.isFromCache {
                            CacheBannerView(lastUpdated: viewModel.lastUpdatedDate)
                        }
            WeatherContentView(weatherData: weatherData)
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ProgressView()
                .tint(themeManager.primaryTextColor)
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }


}


