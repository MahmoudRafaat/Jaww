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
    func formattedForecastDayFull() -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = inputFormatter.date(from: self) else { return self }

            if Calendar.current.isDateInToday(date) {
                return "Today"
            }

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEEE d"
            return outputFormatter.string(from: date)
        }

        func hourFormatted() -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let date = inputFormatter.date(from: self) else { return self }
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h a"
            return outputFormatter.string(from: date)
        }
}
