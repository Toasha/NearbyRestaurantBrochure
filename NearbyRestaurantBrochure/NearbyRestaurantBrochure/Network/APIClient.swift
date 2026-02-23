import Foundation

class APIKeyManager {
    static let shared = APIKeyManager()
    
    init() {}
    
    func apiKey(for service: String) -> String? {
        guard let keys = Bundle.main.infoDictionary?["APIKeys"] as? [String: String] else {
            return nil
        }
        return keys[service]
    }
}

struct APIClient {
    
    func fetchShops(coordinate: Coordinate, range: SearchRange, count: CountParameters) async throws -> [Shop] {
        
        guard let apiKey = APIKeyManager.shared.apiKey(for: "Recruit_API_KEY") else {
            throw URLError(.badURL)
        }
        
        var components = URLComponents(
            string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
        )
        
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
            URLQueryItem(name: "lng", value: "\(coordinate.longitude)"),
            URLQueryItem(name: "range", value: "\(range.rawValue)"),
            URLQueryItem(name: "format", value: "\(count.count)"),
            URLQueryItem(name: "count", value: "1")
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
        
        return response.results.shop
    }
}
