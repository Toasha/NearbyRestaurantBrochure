import Foundation
import Combine

@MainActor
class ShopListViewModel: ObservableObject {
    
    @Published var shops: [Shop] = []
    @Published var coordinate: Coordinate?
    @Published var selectedRange: SearchRange = .km1
    @Published var selectedCount = CountParameters()
    private let apiClient = APIClient()
    
    
    func fetchShops() async {
        guard let coordinate = coordinate else {
            print("座標取得失敗")
            return
        }
        
        do {
            shops = try await apiClient.fetchShops(
                coordinate: coordinate,
                range: selectedRange,
                count: selectedCount.count
            )
        } catch {
            print("APIエラー:", error)
        }
    }
}
