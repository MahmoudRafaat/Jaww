//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//


enum SearchError {
    case none
    case noInternet
    case timeout
    case generic

    var icon: String {
        switch self {
        case .none:        return ""
        case .noInternet:  return "wifi.slash"
        case .timeout:     return "clock.badge.xmark"
        case .generic:     return "wifi.slash"
        }
    }

    var title: String {
        switch self {
        case .none:        return ""
        case .noInternet:  return "No Internet Connection"
        case .timeout:     return "Request Timed Out"
        case .generic:     return "No Internet Connection"
        }
    }

    var message: String {
        switch self {
        case .none:        return ""
        case .noInternet:  return "Check your connection and try again."
        case .timeout:     return "The server took too long to respond. Try again."
        case .generic:     return "Check your connection and try again."
        }
    }
}
