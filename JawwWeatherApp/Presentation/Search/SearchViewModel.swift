import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [SearchCity] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var errorType: SearchError = .none

    private let searchService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(searchService: WeatherServiceProtocol = WeatherService()) {
        self.searchService = searchService
        setupSearchDebounce()
    }

    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                Task { await self.performSearch(query: query) }
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) async {
        guard query.count >= 2 else {
            results = []
            errorType = .none
            return
        }

        isLoading = true
        errorType = .none

        do {
            results = try await searchService.searchCities(query: query)
            errorType = .none
        } catch let urlError as URLError {
            results = []
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                errorType = .noInternet
            case .timedOut:
                errorType = .timeout
            default:
                errorType = .generic
            }
        } catch let nsError as NSError where nsError.domain == NSURLErrorDomain {
            results = []
            errorType = .noInternet
        } catch {
            results = []
            errorType = .generic
        }

        isLoading = false
    }
}

