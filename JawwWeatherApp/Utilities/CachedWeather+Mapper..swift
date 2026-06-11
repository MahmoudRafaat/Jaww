//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//

import Foundation

extension CachedWeather {

    static func from(
        weather: WeatherResponse,
        query: String,
        isFavorite: Bool = false
    ) -> CachedWeather {
        let days = weather.forecast.forecastday.map {
            CachedForecastDay(
                date: $0.date,
                
                maxTempC: $0.day.maxtempC,
                dateEpoch: $0.dateEpoch,
                minTempC: $0.day.mintempC,
                conditionIcon: $0.day.condition.icon,
                conditionText: $0.day.condition.text,
                chanceOfRain: $0.day.dailyChanceOfRain
            )
        }

        return CachedWeather(
            query: query,
            lastUpdated: Date(),
            isFavorite: isFavorite,
            cityName: weather.location.name,
            region: weather.location.region,
            country: weather.location.country,
            tempC: weather.current.tempC,
            feelslikeC: weather.current.feelslikeC,
            conditionText: weather.current.condition.text,
            conditionIcon: weather.current.condition.icon,
            humidity: weather.current.humidity,
            windKph: weather.current.windKph,
            windDir: weather.current.windDir,
            pressureMb: weather.current.pressureMb,
            precipMm: weather.current.precipMm,
            cloud: weather.current.cloud,
            isDay: weather.current.isDay,
            uv: weather.current.uv,
            forecastDays: days
        )
    }

    func toWeatherResponse() -> WeatherResponse {
        WeatherResponse(
            location: Location(
                name: cityName,
                region: region,
                country: country,
                lat: 0,
                lon: 0,
                tzId: "",
                localtimeEpoch: 0,
                localtime: ""
            ),
            current: CurrentWeather(
                lastUpdatedEpoch: 0,
                lastUpdated: "",
                tempC: tempC,
                isDay: isDay,
                condition: WeatherCondition(
                    text: conditionText,
                    icon: conditionIcon,
                    code: 0
                ),
                windKph: windKph,
                windDir: windDir,
                pressureMb: pressureMb,
                precipMm: precipMm,
                humidity: humidity,
                cloud: cloud,
                feelslikeC: feelslikeC,
                uv: uv
            ),
            forecast: Forecast(
                forecastday: forecastDays.map { day in
                    ForecastDay(
                        date: day.date,
                        dateEpoch: day.dateEpoch,
                        day: DayMetrics(
                            maxtempC: day.maxTempC,
                            mintempC: day.minTempC,
                            avgtempC: 0,
                            maxwindKph: 0,
                            totalprecipMm: 0,
                            avgvisKm: 0,
                            avghumidity: 0,
                            dailyChanceOfRain: day.chanceOfRain,
                            condition: WeatherCondition(
                                text: day.conditionText,
                                icon: day.conditionIcon,
                                code: 0
                            ),
                            uv: 0
                        ),
                        astro: Astro(sunrise: "", sunset: "", moonPhase: ""),
                        hour: []
                    )
                }
            )
        )
    }
}
