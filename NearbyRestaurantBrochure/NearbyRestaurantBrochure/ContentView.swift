import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = ShopListViewModel()
    
    private var isInitialLoading: Bool {
        viewModel.shops.isEmpty && viewModel.loadingState != .loaded
    }
    
    var body: some View {
        ZStack {
            ShopListView(viewModel: viewModel)
            
            //起動時のプログレスview
            if isInitialLoading {
                VStack(spacing: 12) {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("読み込み中...")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
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
