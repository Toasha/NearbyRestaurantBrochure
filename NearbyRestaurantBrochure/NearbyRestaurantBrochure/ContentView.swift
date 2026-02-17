import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = ShopListViewModel()
    
    var body: some View {
        ShopListView(viewModel: viewModel)
            .onAppear {
                locationManager.startUpdating()
            }
            .onChange(of: locationManager.coordinate) { coordinate in
                guard let coordinate else { return }
                
                Task {
                    await viewModel.fetchShops(with: coordinate)
                }
            }
    }
}




#Preview {
    ContentView()
}
