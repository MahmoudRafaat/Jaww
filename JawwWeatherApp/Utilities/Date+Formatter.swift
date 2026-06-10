import Foundation
extension String {
    func formattedForecastDay() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else { return self }
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE"
        return outputFormatter.string(from: date)
    }
}
