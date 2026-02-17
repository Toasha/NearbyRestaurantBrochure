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
                guard let coordinate = newValue else { return }
                
                Task {
                    await viewModel.fetchShops(with: coordinate)
                }
            }
    }
}




#Preview {
    ContentView()
}
