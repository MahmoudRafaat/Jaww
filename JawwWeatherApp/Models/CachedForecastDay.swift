//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//
import SwiftData
@Model
class CachedForecastDay {
    var date: String
    var dateEpoch: Int
    var maxTempC: Double
    var minTempC: Double
    var conditionIcon: String
    var conditionText: String
    var chanceOfRain: Int

    init(
           date: String,
           maxTempC: Double,
           dateEpoch: Int,
           minTempC: Double,
           conditionIcon: String,
           conditionText: String,
           chanceOfRain: Int
       ) {
           self.date = date
           self.maxTempC = maxTempC
           self.minTempC = minTempC
           self.conditionIcon = conditionIcon
           self.conditionText = conditionText
           self.chanceOfRain = chanceOfRain
           self.dateEpoch = dateEpoch
       }
    
}
