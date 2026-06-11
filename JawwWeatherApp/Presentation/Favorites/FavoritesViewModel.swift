//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 13/06/2026.
//
import Foundation
@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [CachedWeather] = []
    @Published var showDeleteAlert = false
    @Published var pendingDeleteQuery: String?

    private var cacheService: WeatherCacheServiceProtocol?

    func setUp(cacheService: WeatherCacheServiceProtocol) {
        self.cacheService = cacheService
        loadFavorites()
    }

    func loadFavorites() {
        favorites = cacheService?.allFavorites() ?? []
    }
    func requestDelete(query: String) {
        pendingDeleteQuery = query
        showDeleteAlert = true
    }

    func confirmDelete() {
        guard let query = pendingDeleteQuery else { return }
        try? cacheService?.deleteFavorite(query: query)
        pendingDeleteQuery = nil
        loadFavorites()
    }

    func cancelDelete() {
        pendingDeleteQuery = nil
    }
    func cityName(for query: String) -> String {
        favorites.first { $0.query == query }?.cityName ?? "this city"
    }
}
