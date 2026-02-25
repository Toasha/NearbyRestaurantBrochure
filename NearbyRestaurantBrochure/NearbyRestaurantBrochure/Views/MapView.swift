import SwiftUI
import MapKit

struct MapView: View {
    let shop: Shop
    var searchKey: String {shop.address ?? ""}
    @State private var targetCoordinate: CLLocationCoordinate2D?
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $cameraPosition) {

            if let coordinate = targetCoordinate {
                Marker(shop.name ?? "店舗", coordinate: coordinate)
            }
        }
        .task(id: searchKey) {
            await searchAddress()
        }
    }

    private func searchAddress() async {
        guard !searchKey.isEmpty else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchKey
        let search = MKLocalSearch(request: request)
        
        do {
            let response = try await search.start()
            
            if let firstItem = response.mapItems.first {
                let coordinate: CLLocationCoordinate2D?
                if #available(iOS 26.0, *) {
                    coordinate = firstItem.location.coordinate
                } else {
                    coordinate = firstItem.placemark.coordinate
                }
                if let coordinate {
                    self.targetCoordinate = coordinate
                    self.cameraPosition = .region(MKCoordinateRegion(
                        center: coordinate,
                        latitudinalMeters: 250,
                        longitudinalMeters: 250
                    ))
                }
            }
        } catch {
            print("住所の検索に失敗しました: \(error.localizedDescription)")
        }
    }
}

