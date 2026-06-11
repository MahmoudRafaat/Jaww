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
    @Published var isFromCache = false
    @Published var lastUpdatedDate: Date?
    @Published var isFavorite = false
    @Published var showDeleteFavoriteAlert = false

    private let weatherService: WeatherServiceProtocol
    private var cacheService: WeatherCacheServiceProtocol?
    private let query: String

    init(
        query: String,
        weatherService: WeatherServiceProtocol = WeatherService()
    ) {
        self.query = query
        self.weatherService = weatherService
    }

    func setUp(cacheService: WeatherCacheServiceProtocol) {
        guard self.cacheService == nil else { return }
        self.cacheService = cacheService
        checkFavoriteStatus()
        loadForecast()
    }

    func loadForecast() {
        Task {
            isLoading = true
            errorMessage = nil

            do {
                let data = try await weatherService.fetchForecast(query: query, days: 3)
                try? cacheService?.save(weather: data, query: query, isFavorite: isFavorite)
                weatherResponse = data
                lastUpdatedDate = Date()
                isFromCache = false

            } catch {
                handleOffline()
            }
            isLoading = false
        }
    }


    func toggleFavorite() {
        if isFavorite {
            showDeleteFavoriteAlert = true
        } else {
            addToFavorites()
        }
    }

    func addToFavorites() {
        if let weather = weatherResponse {
            try? cacheService?.save(weather: weather, query: query, isFavorite: true)
        } else {
            try? cacheService?.addFavorite(query: query)
        }
        isFavorite = true
    }

    func removeFromFavorites() {
        try? cacheService?.deleteFavorite(query: query)
        isFavorite = false
    }


    private func checkFavoriteStatus() {
        guard let cached = cacheService?.load(query: query) else { return }
        isFavorite = cached.isFavorite
    }

    private func handleOffline() {
        if let cached = cacheService?.load(query: query) {
            weatherResponse = cached.toWeatherResponse()
            lastUpdatedDate = cached.lastUpdated
            isFromCache = true
        } else {
            errorMessage = "No internet connection and no cached data available."
        }
    }
}
