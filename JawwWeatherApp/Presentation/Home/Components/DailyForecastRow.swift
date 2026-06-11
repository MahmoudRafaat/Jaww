import SwiftUI
import Kingfisher

struct DailyForecastRow: View {
    @EnvironmentObject var themeManager: ThemeManager

    var day: String
    var iconURL: URL?

    
    var minTemp: Int
    var maxTemp: Int
    
    private let scaleMin: CGFloat = 0.0
    private let scaleMax: CGFloat = 50.0
    
    var body: some View {
        HStack(spacing: 16) {
            
            Text(day.formattedForecastDay())
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(themeManager.primaryTextColor)
                .frame(width: 65, alignment: .leading)
            
            VStack(spacing: 4) {
                KFImage(iconURL)
                    .placeholder {
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
               
            }
            .frame(width: 40)
            
            Text("\(minTemp)°")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.gray)
                .frame(width: 45, alignment: .trailing)
            
            GeometryReader { geometry in
                let totalWidth = geometry.size.width
                let scaleRange = scaleMax - scaleMin
                
                let dayRange = CGFloat(maxTemp - minTemp)
                let offsetFromMin = CGFloat(minTemp) - scaleMin
                
                let safeRange = scaleRange <= 0 ? 1 : scaleRange
                
                let barWidth = max(0, (dayRange / safeRange) * totalWidth)
                let barOffset = max(0, (offsetFromMin / safeRange) * totalWidth)
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.black.opacity(0.3))
                        .frame(height: 5)
                    
                    Capsule()
                        .fill(LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: max(barWidth, 5), height: 5)
                        .offset(x: barOffset)
                }
                .frame(height: geometry.size.height, alignment: .center)
            }
            .frame(height: 5)
            .frame(maxWidth: .infinity)
            
            Text("\(maxTemp)°")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(themeManager.primaryTextColor)
                .frame(width: 45, alignment: .trailing)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color(red: 0.12, green: 0.14, blue: 0.17))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            DailyForecastRow(
                day: "Today",
                iconURL: nil,
    
                minTemp: 15,
                maxTemp: 29
            )
            
            Divider().background(Color.gray.opacity(0.5))
            
            DailyForecastRow(
                day: "Mon",
                iconURL: nil,
               
                minTemp: 18,
                maxTemp: 27
            )
            
            Divider().background(Color.gray.opacity(0.5))
            
            DailyForecastRow(
                day: "Tue",
                iconURL: nil,
             
                minTemp: 5,
                maxTemp: 15
            )
        }
        .padding()
        .environmentObject(ThemeManager())
    }
}
