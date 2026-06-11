//
//  ForecastCardView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import SwiftUI

struct ForecastCardView: View {
    let weatherData: WeatherResponse

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
                DailyForecastRow(
                    day: dayData.date,
                    iconURL: URL(string: "https:\(dayData.day.condition.icon)"),
                    minTemp: Int(dayData.day.mintempC),
                    maxTemp: Int(dayData.day.maxtempC)
                )
                Divider().background(Color.gray.opacity(0.5))
            }
        }
        .padding()
        .background(Color(red: 0.12, green: 0.14, blue: 0.17))
        .cornerRadius(16)
    }
}


