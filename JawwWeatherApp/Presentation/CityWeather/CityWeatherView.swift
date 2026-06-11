//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//


import SwiftUI

struct CityWeatherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: CityWeatherViewModel
    @Environment(\.dismiss) private var dismiss

    let city: SearchCity
    let previousScreenTitle: String
    init(city: SearchCity ,  previousScreenTitle: String) {
        self.city = city
        self.previousScreenTitle = previousScreenTitle
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
        .task {
            viewModel.setUp(cacheService: WeatherCacheService(context: context))
        }
        .alert("Remove from Favorites?", isPresented: $viewModel.showDeleteFavoriteAlert) {
            Button("Remove", role: .destructive) {
                viewModel.removeFromFavorites()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to remove \(city.name) from your favorites?")
        }
    }

    private var navigationBar: some View {
        HStack {
             Button { dismiss() } label: {
                 HStack(spacing: 6) {
                     Image(systemName: "chevron.left")
                         .font(.system(size: 16, weight: .semibold))
                     
                     Text(previousScreenTitle)
                         .font(.system(size: 16, weight: .medium))
                 }
                 .foregroundColor(themeManager.primaryTextColor)
                 .padding(.horizontal, 12)
                 .padding(.vertical, 8)
                 .background(Color.white.opacity(0.08))
                 .clipShape(Capsule())
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

            Button {
                viewModel.toggleFavorite()
            } label: {
                Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(viewModel.isFavorite ? .red : themeManager.primaryTextColor)
                    .padding(10)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Circle())
                    .animation(.easeInOut(duration: 0.2), value: viewModel.isFavorite)
            }
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
            VStack(spacing: 0) {
                if viewModel.isFromCache {
                    CacheBannerView(lastUpdated: viewModel.lastUpdatedDate)
                }
                WeatherContentView(weatherData: weatherData)
            }
        }
    }
}
