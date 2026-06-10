
//
//  LocationError.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import CoreLocation

enum LocationError: LocalizedError {
    case denied
    case restricted
    case unknown

    var errorDescription: String? {
        switch self {
        case .denied:     return "Location access denied. Please enable it in Settings."
        case .restricted: return "Location access is restricted on this device."
        case .unknown:    return "Unable to retrieve location."
        }
    }
}
