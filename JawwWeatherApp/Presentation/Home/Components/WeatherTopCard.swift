//
//  WeatherTopCard.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 09/06/2026.
//

import SwiftUI
import Kingfisher

struct WeatherTopCard: View {
    @EnvironmentObject var themeManager: ThemeManager
    let weatherData: WeatherResponse
    
    var body: some View {
        let todayForecast = weatherData.forecast.forecastday.first
        
        VStack(spacing: 4) {

            
            KFImage(URL(string: "https:\(weatherData.current.condition.icon)"))
                .placeholder {
                    ProgressView()
                        .tint(themeManager.primaryTextColor)
                }
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text("\(Int(weatherData.current.tempC))°")
                .font(.system(size: 102, weight: .thin))
                .foregroundColor(themeManager.primaryTextColor)
            
            Text(weatherData.current.condition.text)
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(themeManager.primaryTextColor)
            
            if let today = todayForecast {
                HStack(spacing: 16) {
                    
            
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up")
                            .foregroundColor(.red)
                        Text("H:\(Int(today.day.maxtempC))°")
                    }
                    
                 
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.green)
                        Text("L:\(Int(today.day.mintempC))°")
                    }
                    
                }
               
                .font(.system(size: 21, weight: .medium))
                .foregroundColor(themeManager.primaryTextColor)
            }
        }
    }
}
//#Preview {
//    WeatherTopCard().environmentObject(ThemeManager())
//}
