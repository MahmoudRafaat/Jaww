//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//

import SwiftUI

struct WeatherContentView: View {
    let weatherData: WeatherResponse

    var body: some View {
        ScrollView {
            WeatherTopCard(weatherData: weatherData)
                .padding(.top, 20)
            WeatherCardTemp(current: weatherData.current)
            ForecastCardView(weatherData: weatherData)
        }
        .padding(.horizontal)
    }
}


