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
    @State private var showSplash = true
    @State private var homeOpacity: CGFloat = 0

    var body: some Scene {
        WindowGroup {
            ZStack {
                // ← black base prevents ANY white flash
                Color.black.ignoresSafeArea()

                HomeView()
                    .environmentObject(themeManager)
                    .opacity(homeOpacity)

                if showSplash {
                    SplashScreenView {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            homeOpacity = 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            showSplash = false
                        }
                    }
                    .environmentObject(themeManager)
                    .transition(.opacity)
                    .zIndex(1)   
                }
            }
        }
        .modelContainer(for: [CachedWeather.self, CachedForecastDay.self, CachedHourlyForecast.self])
    }
}
