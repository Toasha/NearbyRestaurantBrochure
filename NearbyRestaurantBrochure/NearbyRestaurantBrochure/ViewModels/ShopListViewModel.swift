import Foundation
import Combine

@MainActor
class ShopListViewModel: ObservableObject {
    
    @Published var shops: [Shop] = []
    
    private let apiClient = APIClient()
    
    func fetchShops(with coordinate: Coordinate) async {
        do {
            shops = try await apiClient.fetchShops(coordinate: coordinate)
        } catch {
            print("APIエラー:", error)
        }
    }
}
