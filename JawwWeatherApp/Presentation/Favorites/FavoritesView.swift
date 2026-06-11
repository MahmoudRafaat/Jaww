import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FavoritesViewModel()

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
        .onAppear {
            viewModel.loadFavorites()
        }
        .alert("Remove from Favorites?", isPresented: $viewModel.showDeleteAlert) {
            Button("Remove", role: .destructive) {
                viewModel.confirmDelete()
            }
            Button("Cancel", role: .cancel) {
                viewModel.cancelDelete()
            }
        } message: {
            if let query = viewModel.pendingDeleteQuery {
                Text("Are you sure you want to remove \(viewModel.cityName(for: query)) from your favorites?")
            }
        }
    }

    private var navigationBar: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Home")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(themeManager.primaryTextColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.08))
                .clipShape(Capsule())
            }

            Spacer()

            Text("Favorites")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(themeManager.primaryTextColor)

            Spacer()
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal)
        .padding(.top, 60)
        .padding(.bottom, 16)
    }

    @ViewBuilder
    private var contentArea: some View {
        if viewModel.favorites.isEmpty {
            emptyState
        } else {
            List {
                ForEach(viewModel.favorites, id: \.query) { cached in
                    NavigationLink(
                        destination: CityWeatherView(
                            city: cached.toSearchCity(),
                            previousScreenTitle: "Favorites"
                        )
                    ) {
                        CityRowView(city: cached.toSearchCity())
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            viewModel.requestDelete(query: cached.query)
                        } label: {
                            Label("Remove", systemImage: "star.slash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "star.slash")
                .font(.system(size: 48))
                .foregroundColor(.gray.opacity(0.4))
            Text("No favorites yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            Text("Tap the star on any city to add it here.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
