//
//  HomeView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 09/06/2026.
//
//



import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var homeModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                Image(themeManager.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    navigationBar()
                    HomeContentView(viewModel: homeModel)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .navigationBarHidden(true)
            .toolbarBackground(.hidden, for: .navigationBar)
            .ignoresSafeArea(.all, edges: .bottom)
            .task { homeModel.loadForecast() }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                if homeModel.weatherResponse == nil {
                    homeModel.loadForecast()
                }
            }
        }.alert("Location Access Needed", isPresented: $homeModel.showLocationSettingsAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enable location access in Settings so Jaww can show your local weather.")
        }
    }
    
}


#Preview {
    HomeView().environmentObject(ThemeManager())
}
