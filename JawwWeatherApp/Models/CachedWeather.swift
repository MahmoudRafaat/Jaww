//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//
import SwiftData
import Foundation
@Model
class CachedWeather {
    @Attribute(.unique) var query: String
      var lastUpdated: Date
      var isFavorite: Bool

      var cityName: String
      var region: String
      var country: String

      var tempC: Double
      var feelslikeC: Double
      var conditionText: String
      var conditionIcon: String
      var humidity: Int
      var windKph: Double
      var windDir: String
      var pressureMb: Double
      var precipMm: Double
      var cloud: Int
      var isDay: Int
      var uv: Double

    @Relationship(deleteRule: .cascade) var forecastDays: [CachedForecastDay]
    init(
           query: String,
           lastUpdated: Date = Date(),
           isFavorite: Bool = false,
           cityName: String,
           region: String,
           country: String,
           tempC: Double,
           feelslikeC: Double,
           conditionText: String,
           conditionIcon: String,
           humidity: Int,
           windKph: Double,
           windDir: String,
           pressureMb: Double,
           precipMm: Double,
           cloud: Int,
           isDay: Int,
           uv: Double,
           forecastDays: [CachedForecastDay]
       ) {
           self.query = query
           self.lastUpdated = lastUpdated
           self.isFavorite = isFavorite
           self.cityName = cityName
           self.region = region
           self.country = country
           self.tempC = tempC
           self.feelslikeC = feelslikeC
           self.conditionText = conditionText
           self.conditionIcon = conditionIcon
           self.humidity = humidity
           self.windKph = windKph
           self.windDir = windDir
           self.pressureMb = pressureMb
           self.precipMm = precipMm
           self.cloud = cloud
           self.isDay = isDay
           self.uv = uv
           self.forecastDays = forecastDays
       }
}
