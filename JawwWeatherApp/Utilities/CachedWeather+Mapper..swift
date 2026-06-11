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
        let days = weather.forecast.forecastday.map { forecastDay in
            CachedForecastDay(
                date: forecastDay.date,
                dateEpoch: forecastDay.dateEpoch,
                maxTempC: forecastDay.day.maxtempC,
                minTempC: forecastDay.day.mintempC,
                conditionIcon: forecastDay.day.condition.icon,
                conditionText: forecastDay.day.condition.text,
                chanceOfRain: forecastDay.day.dailyChanceOfRain,
                hours: forecastDay.hour.map { h in      // ← map hours
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
                condition: WeatherCondition(text: conditionText, icon: conditionIcon, code: 0),
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
                            condition: WeatherCondition(text: day.conditionText, icon: day.conditionIcon, code: 0),
                            uv: 0
                        ),
                        astro: Astro(sunrise: "", sunset: "", moonPhase: ""),
                        hour: day.hours.map { h in       // ← restore hours
                            HourlyForecast(
                                timeEpoch: h.timeEpoch,
                                time: h.time,
                                tempC: h.tempC,
                                isDay: h.isDay,
                                condition: WeatherCondition(text: h.conditionText, icon: h.conditionIcon, code: 0),
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
            )
        )
    }

    func toSearchCity() -> SearchCity {
        SearchCity(id: 0, name: cityName, region: region, country: country, lat: 0, lon: 0, url: query)
    }
}
