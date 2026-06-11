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

        } else if viewModel.errorType != .none {
            VStack(spacing: 16) {
                Image(systemName: viewModel.errorType.icon)
                    .font(.system(size: 44))
                    .foregroundColor(.orange)
                
                Text(viewModel.errorType.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.primaryTextColor)
                
                Text(viewModel.errorType.message)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Button {
                    let current = viewModel.searchText
                    viewModel.searchText = ""
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        viewModel.searchText = current
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.clockwise")
                        Text("Try Again")
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
            else if viewModel.results.isEmpty && viewModel.searchText.count >= 2 {
            VStack(spacing: 12) {
                Image(systemName: "mappin.slash")
                    .font(.system(size: 40))
                    .foregroundColor(themeManager.primaryTextColor)
                Text("No cities found for \"\(viewModel.searchText)\"")
                    .foregroundColor(themeManager.primaryTextColor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if viewModel.searchText.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 40))
                    .foregroundColor(themeManager.primaryTextColor)
                Text("Search for a city")
                    .foregroundColor(themeManager.primaryTextColor)
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
