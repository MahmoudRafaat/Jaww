//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//


import SwiftUI

struct CityWeatherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var viewModel: CityWeatherViewModel
    @Environment(\.dismiss) private var dismiss

    let city: SearchCity

    init(city: SearchCity) {
        self.city = city
        _viewModel = StateObject(wrappedValue: CityWeatherViewModel(query: city.url))
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Image(themeManager.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar
                contentArea
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
        .task { viewModel.loadForecast() }
    }

    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.primaryTextColor)
                    .padding(10)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Circle())
            }

            Spacer()

            VStack(spacing: 2) {
                Text(city.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.primaryTextColor)
                Text("\(city.region), \(city.country)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Spacer()

            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal)
        .padding(.top, 60)
    }

    @ViewBuilder
    private var contentArea: some View {
        if viewModel.isLoading {
            ProgressView()
                .tint(themeManager.primaryTextColor)
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let weatherData = viewModel.weatherResponse {
            WeatherContentView(weatherData: weatherData)
        }
    }
}
