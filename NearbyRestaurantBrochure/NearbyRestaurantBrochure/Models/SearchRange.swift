import Foundation

enum SearchRange: Int, CaseIterable, Identifiable {
    case m300 = 1
    case m500 = 2
    case km1  = 3
    case km2  = 4
    case km3  = 5
    
    var id: Int { rawValue }
    
    var displayText: String {
        switch self {
        case .m300: return "300m"
        case .m500: return "500m"
        case .km1:  return "1km"
        case .km2:  return "2km"
        case .km3:  return "3km"
        }
    }
}
