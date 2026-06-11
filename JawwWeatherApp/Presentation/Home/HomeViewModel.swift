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
    @Published var isFromCache = false
    @Published var lastUpdatedDate: Date?
    
    private let homeQueryKey = "home_location"
      private let weatherService: WeatherServiceProtocol
      private let locationService: LocationServiceProtocol
    private var cacheService: WeatherCacheServiceProtocol?

      init(
          weatherService: WeatherServiceProtocol = WeatherService(),
          locationService: LocationServiceProtocol = LocationService()
      ) {
          self.weatherService = weatherService
          self.locationService = locationService
      }
    
    func setUp(cacheService: WeatherCacheServiceProtocol){
        guard self.cacheService == nil else { return }
        self.cacheService = cacheService
        
    }
    func loadForecast() {
        Task {
                isLocationDenied = false
                isLoadingLocation = true
                errorMessage = nil

                do {
                    let coordinate = try await locationService.requestLocation()
                    isLoadingLocation = false
                    let query = "\(coordinate.latitude),\(coordinate.longitude)"

                    do {
                        let data = try await weatherService.fetchForecast(query: query, days: 3)

                        try? cacheService?.save(weather: data, query: homeQueryKey, isFavorite: false)  
                      
                        weatherResponse = data
                        isFromCache = false

                    } catch   {
                      

                        if let cached = cacheService?.load(query: homeQueryKey) {
                         
                            weatherResponse = cached.toWeatherResponse()
                            lastUpdatedDate = cached.lastUpdated
                            isFromCache = true
                        } else {
                           
                            errorMessage = "No internet connection and no cached data available."
                        }

                    }
                } catch LocationError.denied {
                    isLoadingLocation = false
                    isLocationDenied = true
                    showLocationSettingsAlert = true
                } catch {
                    isLoadingLocation = false
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

