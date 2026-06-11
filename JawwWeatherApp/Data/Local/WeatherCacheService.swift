//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//

import Foundation
import SwiftData

protocol WeatherCacheServiceProtocol {
    func save(weather: WeatherResponse, query: String, isFavorite: Bool) throws
    func load(query: String) -> CachedWeather?
    func addFavorite(query: String) throws
    func deleteFavorite(query: String) throws
    func allFavorites() -> [CachedWeather]
}
    class WeatherCacheService: WeatherCacheServiceProtocol {
        private let context: ModelContext

        init(context: ModelContext) {
            self.context = context
        }

        func save(weather: WeatherResponse, query: String, isFavorite: Bool = false) throws {
            let descriptor = FetchDescriptor<CachedWeather>(
                predicate: #Predicate { $0.query == query }
            )

            if let existing = try? context.fetch(descriptor).first {
                existing.tempC = weather.current.tempC
                existing.feelslikeC = weather.current.feelslikeC
                existing.conditionText = weather.current.condition.text
                existing.conditionIcon = weather.current.condition.icon
                existing.humidity = weather.current.humidity
                existing.windKph = weather.current.windKph
                existing.windDir = weather.current.windDir
                existing.pressureMb = weather.current.pressureMb
                existing.precipMm = weather.current.precipMm
                existing.cloud = weather.current.cloud
                existing.isDay = weather.current.isDay
                existing.uv = weather.current.uv
                existing.lastUpdated = Date()
                existing.forecastDays = weather.forecast.forecastday.map { forecastDay in
                    CachedForecastDay(
                        date: forecastDay.date,
                        dateEpoch: forecastDay.dateEpoch,
                        maxTempC: forecastDay.day.maxtempC,
                        minTempC: forecastDay.day.mintempC,
                        conditionIcon: forecastDay.day.condition.icon,
                        conditionText: forecastDay.day.condition.text,
                        chanceOfRain: forecastDay.day.dailyChanceOfRain,
                        hours: forecastDay.hour.map { h in
                            CachedHourlyForecast(
                                timeEpoch: h.timeEpoch,
                                time: h.time,
                                tempC: h.tempC,
                                isDay: h.isDay,
                                conditionText: h.condition.text,
                                conditionIcon: h.condition.icon,
                                windKph: h.windKph,
                                windDir: h.windDir,
                                humidity: h.humidity,
                                chanceOfRain: h.chanceOfRain,
                                feelslikeC: h.feelslikeC,
                                uv: h.uv
                            )
                        }
                    )
                }
                if isFavorite { existing.isFavorite = true }
            } else {
                context.insert(
                    CachedWeather.from(
                        weather: weather,
                        query: query,
                        isFavorite: isFavorite
                    )
                )
            }
            try context.save()
        }

        func load(query: String) -> CachedWeather? {
            let descriptor = FetchDescriptor<CachedWeather>(
                predicate: #Predicate { $0.query == query }
            )
            return try? context.fetch(descriptor).first
        }

        func addFavorite(query: String) throws {
            let descriptor = FetchDescriptor<CachedWeather>(
                predicate: #Predicate { $0.query == query }
            )
            guard let cached = try? context.fetch(descriptor).first else { return }
            cached.isFavorite = true
            try context.save()
        }

        func deleteFavorite(query: String) throws {
            let descriptor = FetchDescriptor<CachedWeather>(
                predicate: #Predicate { $0.query == query }
            )
            guard let cached = try? context.fetch(descriptor).first else { return }
            context.delete(cached)
            try context.save()
        }

        func allFavorites() -> [CachedWeather] {
            let descriptor = FetchDescriptor<CachedWeather>(
                predicate: #Predicate { $0.isFavorite == true }
            )
            return (try? context.fetch(descriptor)) ?? []
        }
    }
    

