//
//  WeatherCardTemp.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//
import SwiftUI

struct WeatherCardTemp: View {
    @EnvironmentObject var themeManager: ThemeManager
    let current: CurrentWeather

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("VISIBILITY")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Text("\(Int(current.windKph)) KM")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(themeManager.primaryTextColor)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("FEELS LIKE")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Text("\(Int(current.feelslikeC))°")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(themeManager.primaryTextColor)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("PRESSURE")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Text("\(Int(current.pressureMb))")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(themeManager.primaryTextColor)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("HUMIDITY")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Text("\(current.humidity)%")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(themeManager.primaryTextColor)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
            }
            .padding()
        }
    }
}
//#Preview {
//    WeatherCardTemp().environmentObject(ThemeManager())
//}
