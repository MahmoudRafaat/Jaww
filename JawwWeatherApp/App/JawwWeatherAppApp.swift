//
//  JawwWeatherAppApp.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 08/06/2026.
//

import SwiftUI
import SwiftData

@main
struct JawwWeatherAppApp: App {
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(themeManager)
        }
       
    }
}
