import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = ShopListViewModel()
    
    var body: some View {
        ShopListView(viewModel: viewModel)
            .onAppear {
                locationManager.startUpdating()
            }
            .onChange(of: locationManager.coordinate) { _, newValue in
                viewModel.coordinate = newValue
                if let _ = newValue {
                    Task {
                        await viewModel.fetchShops()
                    }
                }
            }
    }
}




#Preview {
    ContentView()
}
