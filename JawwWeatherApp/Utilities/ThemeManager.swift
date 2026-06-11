
import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isMorning: Bool = true
    
    init() {
        updateTheme()
    }
    
    func updateTheme() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
    
        if hour >= 5 && hour < 18 {
            isMorning = true
        } else {
            isMorning = false
        }
    }

    var primaryTextColor: Color {
        return isMorning ? .black : .white
    }
    
    var backgroundImageName: String {
        return isMorning ? "morning_background" : "dark_background"
    }
    var cardBackgroundColor: Color {
            return isMorning ? Color.white.opacity(0.5) : Color(red: 0.12, green: 0.14, blue: 0.17)
        }
}
