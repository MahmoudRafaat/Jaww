//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//
import SwiftData
import Foundation

@Model
class CachedForecastDay {
    var date: String
    var dateEpoch: Int = 0
    var maxTempC: Double
    var minTempC: Double
    var conditionIcon: String
    var conditionText: String
    var chanceOfRain: Int

    @Relationship(deleteRule: .cascade) var hours: [CachedHourlyForecast]  

    init(
        date: String,
        dateEpoch: Int = 0,
        maxTempC: Double,
        minTempC: Double,
        conditionIcon: String,
        conditionText: String,
        chanceOfRain: Int,
        hours: [CachedHourlyForecast] = []
    ) {
        self.date = date
        self.dateEpoch = dateEpoch
        self.maxTempC = maxTempC
        self.minTempC = minTempC
        self.conditionIcon = conditionIcon
        self.conditionText = conditionText
        self.chanceOfRain = chanceOfRain
        self.hours = hours
    }
}
