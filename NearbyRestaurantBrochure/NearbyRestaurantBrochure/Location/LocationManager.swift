import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var coordinate: Coordinate? {
        guard let location else { return nil }
        return Coordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // 位置情報の許可をリクエスト
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    // 現在地の取得を開始
    func startUpdating() {
        manager.startUpdatingLocation()
    }
    
    // 現在地の取得を停止
    func stopUpdating() {
        manager.stopUpdatingLocation()
    }
    
    // 位置情報が更新されたときに呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    // 権限の状態が変わったときに呼ばれる
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdating()
        case .denied, .restricted:
            print("位置情報の権限がありません")
        case .notDetermined:
            requestPermission()
        @unknown default:
            break
        }
    }
    
    // エラーが発生したときに呼ばれる
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗: \(error.localizedDescription)")
    }
}
