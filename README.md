# JAWW Weather

![Platform](https://img.shields.io/badge/platform-iOS%2017%2B-blue?style=flat-square)
![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5-blue?style=flat-square)
![SwiftData](https://img.shields.io/badge/SwiftData-✓-green?style=flat-square)

JAWW is a native iOS weather app built entirely with SwiftUI. It shows real-time weather for your current location, lets you search and save cities, and works fully offline using a SwiftData cache.

---

## 📸 Screenshots

<!-- Home Screen -->
<!-- Search Screen -->
<!-- City Weather Screen -->
<!-- Favorites Screen -->
<!-- Hourly Forecast Screen -->

---

## ✨ Features

### 🏠 Home Screen
- Automatic current location weather via `CLLocationManager`
- Current temperature, feels-like, humidity, wind, pressure, UV index
- Condition icon loaded from WeatherAPI CDN via Kingfisher
- Location permission denied state with direct "Go to Settings" button
- Offline banner showing "Last updated X ago" when serving cached data
- Auto-refresh when returning from background (30-minute staleness threshold)

### 📅 3-Day Forecast
- Daily rows with min/max temperature
- Animated temperature range bar scaled across a 0–50°C scale
- Rain chance indicator per day
- Tap any day to open the hourly forecast screen

### 🕐 Hourly Forecast
- 24-hour breakdown per selected day
- Current hour row highlighted with blue background, border, and "Now" badge
- Hours sorted so current hour appears first for today
- Navigation bar shows "Today" or full day name + date ("Friday 14")

### 🔍 City Search
- Debounced search input (400ms) via Combine — no API call on every keystroke
- `removeDuplicates()` prevents redundant requests
- Results show city name, region, country
- User-friendly error states: no internet, timeout, generic — never raw system errors
- Retry button on error state

### ⭐ Favorites
- Add/remove cities from any city weather screen via star button
- Star turns red when favorited, confirmation alert before removal
- Dedicated favorites screen with swipe-to-delete (also with confirmation alert)
- Empty state when no favorites saved
- List refreshes automatically when returning from city screen

### 📡 Offline Support
- All weather data auto-cached to SwiftData on every successful fetch
- `URLError` caught specifically — falls back to cache silently
- Stale banner shown when serving cached data
- Home weather uses fixed `"home_location"` key regardless of GPS drift
- City weather cached per URL slug query key

### 🌅 Theme System
- Background image and text colors adapt to time of day:
  - Morning (6–11): morning theme
  - Day (12–17): day theme
  - Evening (18–21): evening theme
  - Night (22–5): night theme
- `ThemeManager` published as `@EnvironmentObject` across all screens

### 🚀 Splash Screen
- Native iOS launch screen matching app brand colors
- Animated splash with:
  - Three expanding rings with staggered delays
  - App icon spring-bounce
  - Title and subtitle slide-up with spring physics
  - 35 floating particles via `Canvas` + `TimelineView`
- `HomeView` loads silently underneath during animation — no delay after transition
- `Color.black` base prevents white flash between splash and home

---

## 🏗 Architecture

JAWW follows **MVVM** strictly. Views own zero business logic — they observe ViewModels and render state. ViewModels call Services. Services are injected via protocols for testability.

```
View  →  observes  →  ViewModel  →  calls  →  Service (Protocol)
 ↑                        ↓
@EnvironmentObject     @Published state
```

### ViewModels

| ViewModel | Owns |
|---|---|
| `HomeViewModel` | Location fetching, home weather, cache save/load, offline fallback |
| `CityWeatherViewModel` | City weather by URL slug, favorite toggle, cache fallback |
| `SearchViewModel` | Debounced city search, error mapping |
| `FavoritesViewModel` | Favorites list, delete with confirmation |

### Services & Protocols

| Protocol | Implementation | Responsibility |
|---|---|---|
| `WeatherServiceProtocol` | `WeatherService` | Fetch forecast + search from WeatherAPI |
| `LocationServiceProtocol` | `LocationService` | Request device location via CLLocationManager |
| `WeatherCacheServiceProtocol` | `WeatherCacheService` | SwiftData read/write for weather cache and favorites |

All ViewModels accept protocol types in their `init` — mock implementations can be injected for previews and tests.

---

## 📁 Project Structure

```
JawwWeatherApp/
├── App/
│   ├── JawwWeatherAppApp.swift        # Entry point, modelContainer, splash logic
│   └── AppContainerView.swift         # Builds cacheService + injects into HomeView
│
├── Models/
│   ├── WeatherResponse.swift          # Full Codable API response models
│   ├── SearchCity.swift               # Search result model
│   └── SearchError.swift             # User-facing error enum
│
├── SwiftData/
│   ├── CachedWeather.swift            # @Model — current weather + relationships
│   ├── CachedForecastDay.swift        # @Model — forecast day + hours relationship
│   ├── CachedHourlyForecast.swift     # @Model — individual hour data
│   └── CachedWeather+Mapper.swift     # from() and toWeatherResponse() mappers
│
├── Services/
│   ├── WeatherService.swift           # WeatherAPI network calls
│   ├── WeatherServiceProtocol.swift
│   ├── LocationService.swift          # CLLocationManager → async/await
│   ├── LocationServiceProtocol.swift
│   ├── WeatherCacheService.swift      # SwiftData CRUD
│   └── WeatherCacheServiceProtocol.swift
│
├── ViewModels/
│   ├── HomeViewModel.swift
│   ├── CityWeatherViewModel.swift
│   ├── SearchViewModel.swift
│   └── FavoritesViewModel.swift
│
├── Views/
│   ├── Home/
│   │   ├── HomeView.swift
│   │   ├── HomeContentView.swift
│   │   └── NavigationBar.swift
│   ├── Weather/
│   │   ├── WeatherContentView.swift   # Shared between Home and City
│   │   ├── WeatherTopCard.swift
│   │   ├── WeatherCardTemp.swift
│   │   ├── ForecastCardView.swift
│   │   ├── DailyForecastRow.swift
│   │   └── CacheBannerView.swift
│   ├── Hourly/
│   │   ├── HourlyForecastView.swift
│   │   └── HourlyForecastRow.swift
│   ├── Search/
│   │   ├── SearchView.swift
│   │   ├── SearchContentView.swift
│   │   └── CityRowView.swift
│   ├── City/
│   │   └── CityWeatherView.swift
│   ├── Favorites/
│   │   └── FavoritesView.swift
│   ├── Shared/
│   │   ├── LocationDeniedView.swift
│   │   └── SplashScreenView.swift
│
├── Extensions/
│   ├── Date+Formatter.swift           # formattedForecastDay(), formattedForecastDayFull(), hourFormatted()
│   └── CachedWeather+SearchCity.swift # toSearchCity() for reusing CityRowView
│
├── Theme/
│   └── ThemeManager.swift             # Time-based background + color management
│
└── Config/
    ├── Secrets.xcconfig               # API_KEY, BASE_URL_HOST (gitignored)
    └── Config.swift                   # Safe Bundle.main.infoDictionary access
```

---

## 🛠 Tech Stack

| Technology | Usage |
|---|---|
| **SwiftUI** | All UI — views, animations, navigation |
| **SwiftData** | Local persistence for weather cache and favorites |
| **Combine** | Debounced search via `$searchText` publisher |
| **CoreLocation** | Device GPS via `CLLocationManager` |
| **Kingfisher** | Async weather condition icon loading with placeholder |
| **WeatherAPI.com** | Forecast and city search REST API |

---

## 🔄 Data Flow

### Weather fetch flow
```
HomeView.task
    │
    ▼
HomeViewModel.loadForecast()
    │
    ▼
LocationService.requestLocation()     ← CLLocationManager → CheckedContinuation
    │
    ▼
WeatherService.fetchForecast(query:)  ← "lat,lon" or city.url slug
    │
    ├── success → WeatherCacheService.save() → weatherResponse published → UI renders
    │
    └── URLError → WeatherCacheService.load() → cached data → isFromCache = true → banner shown
```

### Cache fallback strategy
```
fetch() succeeds   →  save to SwiftData  →  show fresh data
fetch() URLError   →  load from SwiftData  →  show stale banner with timestamp
fetch() URLError + no cache  →  show error message
other error (401, 500 etc)   →  show error message (not a cache fallback case)
```

### Location flow
`CLLocationManager` uses delegate callbacks which don't natively support `async/await`. `LocationService` bridges them using `CheckedContinuation`:

```swift
func requestLocation() async throws -> CLLocationCoordinate2D {
    return try await withCheckedThrowingContinuation { continuation in
        self.continuation = continuation
        manager.requestLocation()
    }
}

// delegate fires later:
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    resume(returning: locations.first!.coordinate)  // unpauses the async function
}
```

Safe `resume()` helpers ensure the continuation is always nilled after use — prevents both leaks and double-resume crashes.

---

## 💾 SwiftData Models

```
CachedWeather                          ← @Model, @Attribute(.unique) query
│   query: String                      ← "home_location" or city.url slug
│   cityName, region, country
│   tempC, feelslikeC, humidity, ...   ← full current weather fields
│   isFavorite: Bool
│   lastUpdated: Date
│
└── @Relationship(cascade) forecastDays: [CachedForecastDay]
        │   date, dateEpoch
        │   maxTempC, minTempC
        │   conditionText, conditionIcon
        │   chanceOfRain
        │
        └── @Relationship(cascade) hours: [CachedHourlyForecast]
                    time, timeEpoch
                    tempC, feelslikeC
                    conditionText, conditionIcon
                    windKph, humidity, chanceOfRain, uv
```

Cascade delete means removing a `CachedWeather` record automatically removes all linked forecast days and their hourly records.

The mapper `CachedWeather+Mapper` handles two-way conversion:
- `CachedWeather.from(weather:query:)` → `WeatherResponse` to SwiftData
- `toWeatherResponse()` → SwiftData back to `WeatherResponse` for the UI

---

## ⚙️ Setup & Configuration

### 1. Create `Secrets.xcconfig`

```
BASE_URL_HOST = api.weatherapi.com/v1
API_KEY = your_api_key_here
```

> **Important:** Do not write `http://api.weatherapi.com` directly in the xcconfig file. The `//` in `http://` is treated as a comment by the xcconfig parser, silently truncating the value. Split the scheme and host — the full URL is reconstructed in code.

### 2. Add to `Info.plist`

```xml
<key>API_KEY</key>
<string>$(API_KEY)</string>
<key>BASE_URL_HOST</key>
<string>$(BASE_URL_HOST)</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>JAWW uses your location to show local weather conditions.</string>
```

### 3. Read in `Config.swift`

```swift
enum Config {
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    static let baseURL = "http://\(Bundle.main.infoDictionary?["BASE_URL_HOST"] as? String ?? "")"
}
```

### 4. Add `Secrets.xcconfig` to `.gitignore`

```
Secrets.xcconfig
```

---

## 🌐 API

Base URL: `http://api.weatherapi.com/v1`

### Forecast
```
GET /forecast.json?key={API_KEY}&q={query}&days=3
```
`query` accepts: `"lat,lon"`, city name, or URL slug (e.g. `"cairo-al-qahirah-egypt"`)

### Search
```
GET /search.json?key={API_KEY}&q={query}
```
Returns an array of matching cities with id, name, region, country, lat, lon, and url slug.

The API key is never hardcoded — it is read from `Info.plist` at runtime via `Bundle.main.infoDictionary` and injected into each request URL by the service layer.

---



## 📄 License

MIT
