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
                if newValue != nil && viewModel.shops.isEmpty {
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
