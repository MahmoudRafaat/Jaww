
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
        return isMorning ? .white : .white
    }
    
    var backgroundImageName: String {
        return isMorning ? "dark_background" : "dark_background"
    }
}
