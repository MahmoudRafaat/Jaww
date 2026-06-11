//
//  SearchContentView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

// SearchContentView.swift
import SwiftUI

struct SearchContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .tint(themeManager.primaryTextColor)
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if let error = viewModel.errorMessage {
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.orange)
                Text(error)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if viewModel.results.isEmpty && viewModel.searchText.count >= 2 {
            VStack(spacing: 12) {
                Image(systemName: "mappin.slash")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                Text("No cities found for \"\(viewModel.searchText)\"")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if viewModel.searchText.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 40))
                    .foregroundColor(.gray.opacity(0.4))
                Text("Search for a city")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.results) { city in
                        NavigationLink(destination: CityWeatherView(city: city,previousScreenTitle: "Search")) {
                            CityRowView(city: city)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    SearchContentView(viewModel: SearchViewModel())
        .environmentObject(ThemeManager())
}
