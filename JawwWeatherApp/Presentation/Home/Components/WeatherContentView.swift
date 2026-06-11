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
            ForecastCardView(weatherData: weatherData)
            WeatherCardTemp(current: weatherData.current)
           
        }
        .padding(.horizontal)
    }
}


