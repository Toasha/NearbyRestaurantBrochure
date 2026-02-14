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
    
    func fetchShops() async throws -> [Shop] {
        
        guard let apiKey = APIKeyManager().apiKey(for: "Recruit_API_KEY") else {
            throw URLError(.badURL)
        }
        
        var components = URLComponents(
            string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
        )
        
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "lat", value: "35.681236"),
            URLQueryItem(name: "lng", value: "139.767125"),
            URLQueryItem(name: "range", value: "3"),
            URLQueryItem(name: "format", value: "json")
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
        
        return response.results.shop
    }
}





