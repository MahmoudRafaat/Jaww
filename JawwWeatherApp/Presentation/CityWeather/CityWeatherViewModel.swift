//
//  CityWeatherViewModel.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//

import Foundation

@MainActor
class CityWeatherViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let weatherService: WeatherServiceProtocol
    private let query: String

    init(
        query: String,
        weatherService: WeatherServiceProtocol = WeatherService()
    ) {
        self.query = query
        self.weatherService = weatherService
    }

    func loadForecast() {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                weatherResponse = try await weatherService.fetchForecast(query: query, days: 3)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
