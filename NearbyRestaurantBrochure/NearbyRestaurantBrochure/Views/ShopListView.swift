import SwiftUI

struct ShopListView: View {
    
    @ObservedObject var viewModel: ShopListViewModel
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.shops, id: \.name) { shop in
                            ShopCardView(shop: shop)
                        }
                    }
                    .padding()
                }
                Button {
                    showDetail = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.orange)
                                .shadow(color: .black.opacity(0.2),
                                        radius: 8,
                                        x: 0,
                                        y: 4)
                        )
                }
                .padding(.trailing, 20)
                .padding(.bottom, 30)
                .sheet(isPresented: $showDetail) {
                    Text("詳細フィルタ")
                }
            }
            .navigationTitle("付近の店舗")
        }
    }
}
