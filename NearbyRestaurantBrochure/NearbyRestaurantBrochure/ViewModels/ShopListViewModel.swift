import Foundation
import Combine

@MainActor
class ShopListViewModel: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case error
    }
    
    @Published var shops: [Shop] = []
    @Published var coordinate: Coordinate?
    @Published var selectedRange: SearchRange = .km1
    @Published var selectedCount = CountParameters()
    @Published var loadingState: LoadingState = .idle
    private let apiClient = APIClient()
    
    
    func fetchShops() async {
        guard let coordinate = coordinate else {
            print("座標取得失敗")
            return
        }
        
        loadingState = .loading
        
        do {
            shops = try await apiClient.fetchShops(
                coordinate: coordinate,
                range: selectedRange,
                count: selectedCount.count
            )
            loadingState = .loaded
        } catch {
            print("APIエラー:", error)
            loadingState = .error
        }
    }
}
