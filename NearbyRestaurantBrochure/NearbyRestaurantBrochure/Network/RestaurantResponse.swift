import Foundation

struct RestaurantResponse: Decodable {
    let results: Results
}

struct Results: Decodable {
    let shop: [Shop]
}

struct Shop: Decodable {
    let name: String?
    let lat: Double?
    let lng: Double?
    let address: String?
    let access: String?
    let mobileAccess: String?
    let open: String?
    let budget: Budget?
    let photo: Photo?
    
    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lng
        case address
        case access
        case mobileAccess = "mobile_access"
        case open
        case budget
        case photo
    }
}
extension Shop {
    static var mock: Shop {
        Shop(name: "Loading Store Name", lat: nil, lng: nil, address: nil, access: "Loading access info...", mobileAccess: nil, open: nil, budget: nil, photo: nil)
    }
}

// MARK: - Budget
struct Budget: Decodable {
    let average: String?
}

// MARK: - Photo
struct Photo: Decodable {
    let mobile: PhotoSize?
    let pc: PhotoSize?
}

// MARK: - PhotoMobile
struct PhotoMobile: Decodable {
    let l: String?
    let s: String?
}

//MARK: - PhotoSize
struct PhotoSize: Decodable {
    let l: String?
    let m: String?
    let s: String?
}
