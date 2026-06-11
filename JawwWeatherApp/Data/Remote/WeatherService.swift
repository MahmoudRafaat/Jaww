//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import Foundation
import Alamofire

protocol WeatherServiceProtocol {
    func fetchForecast(query: String, days: Int) async throws -> WeatherResponse
    func searchCities(query: String) async throws -> [SearchCity]
}

class WeatherService: WeatherServiceProtocol {
 
    
    private let session: Session
    
    init() {
        let interceptor = APIKeyInterceptor()
        self.session = Session(interceptor: interceptor)
    }
    
    func fetchForecast(query: String, days: Int) async throws -> WeatherResponse {
        
        let url = "https://\(Config.baseURL)/forecast.json"
  
        let parameters: Parameters = [
            "q": query,
            "days": days
        ]

        return try await session.request(url, parameters: parameters)
            .validate()
            .serializingDecodable(WeatherResponse.self)
            .value
    }
    func searchCities(query: String) async throws -> [SearchCity] {
           guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return [] }
           
        
        let url = "https://\(Config.baseURL)/search.json"
  
        let parameters: Parameters = [
            "q": query
           
        ]

        return try await session.request(url, parameters: parameters)
            .validate()
            .serializingDecodable([SearchCity].self)
            .value
       }
}
