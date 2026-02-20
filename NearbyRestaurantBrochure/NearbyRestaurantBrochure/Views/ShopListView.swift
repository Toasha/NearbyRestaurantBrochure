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
                                .scrollTransition(.interactive) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                }
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
                                .glassEffect()
                                .shadow(color: .black.opacity(0.2),
                                        radius: 8,
                                        x: 0,
                                        y: 4)
                        )
                }
                .padding(.trailing, 20)
                .padding(.bottom, 30)
                .sheet(isPresented: $showDetail) {
                    FilterSheetView(viewModel: viewModel)
                        .presentationDetents([.medium,.large])
                        .presentationBackground(Color(.systemBackground))
                }
            }
            .navigationTitle("付近の店舗")
        }
    }
}
