import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [SearchCity] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

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
                Task {
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) async {
        isLoading = true
        errorMessage = nil

        do {
            results = try await searchService.searchCities(query: query)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
