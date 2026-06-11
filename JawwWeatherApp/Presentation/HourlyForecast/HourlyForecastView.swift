
import SwiftUI

struct HourlyForecastView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss

    let day: ForecastDay
    let cityName: String

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Image(themeManager.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 10) {
                        ForEach(day.hour) { hour in
                            HourlyForecastRow(hour: hour)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }

    private var navigationBar: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text(cityName)
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
                Text(day.date.formattedForecastDay())
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.primaryTextColor)
                Text("Hourly Forecast")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Spacer()
            Color.clear.frame(width: 80, height: 44)
        }
        .padding(.horizontal)
        .padding(.top, 60)
        .padding(.bottom, 16)
    }
}
