import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var shops: [Shop] = []
    
    var body: some View {
        VStack {
            
            if let firstShop = shops.last {
                Text(firstShop.name ?? "名前なし")
                    .font(.title)
            } else {
                Text("お店を取得中...")
            }
        }
        .onAppear {
            locationManager.startUpdating()
        }
        .onChange(of: locationManager.coordinate) { coordinate in
            guard let coordinate else { return }
            
            Task {
                do {
                    shops = try await APIClient().fetchShops(coordinate: coordinate)
                } catch {
                    print("APIエラー:", error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
