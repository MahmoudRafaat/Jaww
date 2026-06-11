
import Foundation


struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

struct CurrentWeather: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let windDir: String
    let pressureMb: Double
    let precipMm: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case precipMm = "precip_mm"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case uv
    }
}


struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

// MARK: - Forecast Day
struct ForecastDay: Codable, Identifiable {
    var id: Int { dateEpoch }
    let date: String
    let dateEpoch: Int
    let day: DayMetrics
    let astro: Astro
    let hour: [HourlyForecast]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}


struct DayMetrics: Codable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let maxwindKph: Double
    let totalprecipMm: Double
    let avgvisKm: Double
    let avghumidity: Int
    let dailyChanceOfRain: Int
    let condition: WeatherCondition
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case avgvisKm = "avgvis_km"
        case avghumidity
        case dailyChanceOfRain = "daily_chance_of_rain"
        case condition, uv
    }
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonPhase: String
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
        case moonPhase = "moon_phase"
    }
}

struct HourlyForecast: Codable, Identifiable {
    var id: Int { timeEpoch }
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let windDir: String
    let humidity: Int
    let chanceOfRain: Int
    let feelslikeC: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case humidity
        case chanceOfRain = "chance_of_rain"
        case feelslikeC = "feelslike_c"
        case uv
    }
}


struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}
