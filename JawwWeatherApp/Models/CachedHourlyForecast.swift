//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//

import SwiftData
import Foundation

@Model
class CachedHourlyForecast {
    var timeEpoch: Int = 0
    var time: String
    var tempC: Double
    var isDay: Int
    var conditionText: String
    var conditionIcon: String
    var windKph: Double
    var windDir: String
    var humidity: Int
    var chanceOfRain: Int
    var feelslikeC: Double
    var uv: Double

    init(
        timeEpoch: Int = 0,
        time: String,
        tempC: Double,
        isDay: Int,
        conditionText: String,
        conditionIcon: String,
        windKph: Double,
        windDir: String,
        humidity: Int,
        chanceOfRain: Int,
        feelslikeC: Double,
        uv: Double
    ) {
        self.timeEpoch = timeEpoch
        self.time = time
        self.tempC = tempC
        self.isDay = isDay
        self.conditionText = conditionText
        self.conditionIcon = conditionIcon
        self.windKph = windKph
        self.windDir = windDir
        self.humidity = humidity
        self.chanceOfRain = chanceOfRain
        self.feelslikeC = feelslikeC
        self.uv = uv
    }
}
