//
//  ForecastCardView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import SwiftUI

struct ForecastCardView: View {
    let weatherData: WeatherResponse
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                Text("3-DAY FORECAST")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }

            Divider().background(Color.gray.opacity(0.5))
            ForEach(weatherData.forecast.forecastday) { dayData in
                NavigationLink(destination: HourlyForecastView(
                    day: dayData,
                    cityName: weatherData.location.name
                )) {
                    DailyForecastRow(
                        day: dayData.date,
                        iconURL: URL(string: "https:\(dayData.day.condition.icon)"),
                        minTemp: Int(dayData.day.mintempC),
                        maxTemp: Int(dayData.day.maxtempC)
                    )
                }
                .buttonStyle(.plain)
                Divider().background(Color.gray.opacity(0.5))
            }
        }
        .padding()
        .background(themeManager.cardBackgroundColor)
        .cornerRadius(16)
    }
}


