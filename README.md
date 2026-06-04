# جو | Jaww — Weather App

> *"Jaww" (جو) — Arabic for "atmosphere" and "weather". A name that speaks for itself.*

Jaww is a native iOS weather application built with SwiftUI that delivers real-time weather conditions, multi-day forecasts, and an immersive time-aware UI — all powered by live data from WeatherAPI.

---

## 🛠️ Technologies Used

### 🍎 SwiftUI
**What it is:** Apple's modern declarative UI framework introduced in 2019, used to build the entire interface of Jaww.

**Why it's used here:**
- Build beautiful, responsive screens with less code
- Declarative syntax makes UI state management clean and predictable
- Native support for animations, transitions, and dark/light mode
- Built-in navigation stack for moving between screens (Home → Hourly Forecast → Saved Locations)

---

### 🌐 URLSession
**What it is:** Apple's built-in networking framework for making HTTP requests — no third-party libraries needed.

**Why it's used here:**
- Fetches live weather data from the WeatherAPI REST endpoint
- Handles asynchronous network calls using Swift's modern `async/await` syntax
- Lightweight and fully native — no extra dependencies

---

### 🔄 Codable (JSONDecoder)
**What it is:** Swift's built-in protocol for encoding and decoding data — used here to parse JSON responses from the API into Swift model objects.

**Why it's used here:**
- Automatically maps the WeatherAPI JSON response into clean Swift structs
- Handles nested JSON objects like `forecast`, `hour`, `condition`, and `day`
- Type-safe and eliminates manual JSON parsing

---

### 📐 MVVM Architecture (Model - View - ViewModel)
**What it is:** A software design pattern that separates the app into three layers — data (Model), UI (View), and logic (ViewModel).

**Why it's used here:**
- Keeps SwiftUI Views clean — they only handle what the user sees
- ViewModels manage all API calls, data transformation, and state
- Makes the codebase scalable, testable, and easy to maintain

```
Model       →  Weather data structures (WeatherModel, ForecastModel)
View        →  SwiftUI screens (HomeView, HourlyView, SearchView)
ViewModel   →  Business logic & API layer (WeatherViewModel)
```

---

### 📍 CoreLocation
**What it is:** Apple's framework for accessing the device's GPS and location services.

**Why it's used here:**
- Detects the user's current coordinates (latitude & longitude)
- Passes the coordinates to WeatherAPI to fetch local weather automatically
- Requests location permission from the user on first launch

---

### ☁️ WeatherAPI.com (REST API)
**What it is:** A third-party weather data provider offering real-time conditions, forecasts, astronomy data, and more via a simple REST API.

**Why it's used here:**
- Provides current weather, 3-day forecast, and hourly data in one call
- Supports querying by city name (for search) or coordinates (for current location)
- Free tier available with sufficient data for this project

**Endpoint used:**
```
GET http://api.weatherapi.com/v1/forecast.json
    ?key=[API_KEY]
    &q=[LAT],[LON]
    &days=3
    &aqi=yes
    &alerts=no
```

**Key data returned:**
| Field | Used For |
|---|---|
| `current.temp_c` | Current temperature |
| `current.condition` | Condition text + icon |
| `current.humidity` | Humidity detail card |
| `current.vis_km` | Visibility detail card |
| `current.feelslike_c` | Feels Like detail card |
| `current.pressure_mb` | Pressure detail card |
| `forecast.forecastday` | 3-day forecast list |
| `forecast.forecastday.hour` | Hourly forecast screen |

---

### 💾 UserDefaults
**What it is:** Apple's simple key-value persistent storage system, built into iOS.

**Why it's used here:**
- Saves the user's list of added locations between app sessions
- Lightweight and perfect for storing a small list of city names or coordinates
- No database setup required

---

### 🎨 Assets & Dynamic Theming
**What it is:** Custom image assets combined with SwiftUI's environment and conditional rendering.

**Why it's used here:**
- Morning background image displayed between **5:00 AM and 6:00 PM** with **black** text
- Evening background image displayed after **6:00 PM and before 5:00 AM** with **white** text
- Theme switches automatically based on the device's current time using `Date()` and `Calendar`

---

## 📱 App Screens Summary

| Screen | Description |
|---|---|
| **Home** | Current weather, 3-day forecast list, 4 detail cards |
| **Hourly Forecast** | Hour-by-hour breakdown for a selected day |
| **Search** | Search any city globally via WeatherAPI |
| **Saved Locations** | List of user-saved cities with quick navigation |

---

## 🔗 Key Dependencies

| Tool / Framework | Type | Purpose |
|---|---|---|
| SwiftUI | Native (Apple) | UI framework |
| URLSession | Native (Apple) | Networking |
| Codable | Native (Swift) | JSON parsing |
| CoreLocation | Native (Apple) | GPS & location |
| UserDefaults | Native (Apple) | Local persistence |
| WeatherAPI.com | Third-party REST API | Weather data source |

> ✅ **No third-party Swift packages (SPM/CocoaPods) are required.** Everything except the external API is built on Apple's native frameworks.

---

*Jaww — جو — Because weather is more than just a forecast.*
