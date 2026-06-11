//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import Foundation
import Alamofire

final class APIKeyInterceptor : RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        guard let url = request.url,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return completion(.success(urlRequest))
        }
        
        let keyQuery = URLQueryItem(name: "key", value: Config.apiKey)
        components.queryItems = (components.queryItems ?? []) + [keyQuery]
        
        request.url = components.url
        completion(.success(request))
    }
}
