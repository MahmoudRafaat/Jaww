//
//  HomeView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 09/06/2026.
//
//
import SwiftUI
import Kingfisher
struct HourlyForecastRow: View {
    let hour: HourlyForecast

    var body: some View {
        HStack(spacing: 16) {
            Text(hour.time.hourFormatted())
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.gray)
                .frame(width: 55, alignment: .leading)

            KFImage(URL(string: "https:\(hour.condition.icon)"))
                .placeholder {
                    Image(systemName: "cloud.fill")
                        .foregroundColor(.gray.opacity(0.3))
                }
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)

            Text(hour.condition.text)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineLimit(1)

            Spacer()

            if hour.chanceOfRain > 0 {
                HStack(spacing: 3) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.blue)
                    Text("\(hour.chanceOfRain)%")
                        .font(.system(size: 13))
                        .foregroundColor(.blue)
                }
            }

            Text("\(Int(hour.tempC))°")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 45, alignment: .trailing)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color(red: 0.12, green: 0.14, blue: 0.17))
        .cornerRadius(14)
    }
}
