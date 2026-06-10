//
//  HomeViewModel.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import Foundation
@MainActor
class HomeViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    @Published var errorMessage: String?
    @Published var showLocationSettingsAlert = false
    @Published var isLocationDenied = false
    @Published var isLoadingLocation = false
    private let weatherService: WeatherServiceProtocol
    private let locationService: LocationServiceProtocol
    
    
    init(
        weatherService: WeatherServiceProtocol = WeatherService(),
        locationService: LocationServiceProtocol = LocationService()
    ) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    func loadForecast() {
        Task {
            do {
                isLocationDenied = false 
                isLoadingLocation = true
                let coordinate = try await locationService.requestLocation()
                isLoadingLocation = false
                let query = "\(coordinate.latitude),\(coordinate.longitude)"
                self.weatherResponse = try await weatherService.fetchForecast(query: query, days: 3)
            } catch LocationError.denied {
                isLoadingLocation = false
                isLocationDenied = true
                showLocationSettingsAlert = true
            } catch {
                isLoadingLocation = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
