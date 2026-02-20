import Foundation
import Combine

@MainActor
class ShopListViewModel: ObservableObject {
    
    @Published var shops: [Shop] = []
    @Published var selectedRange: SearchRange = .km1
    private let apiClient = APIClient()
    
    func fetchShops(with coordinate: Coordinate) async {
        do {
            shops = try await apiClient.fetchShops(coordinate: coordinate, range: selectedRange)
        } catch {
            print("APIエラー:", error)
        }
    }
}
