import SwiftUI
import Shimmer

struct ShopListView: View {
    
    @ObservedObject var viewModel: ShopListViewModel
    @State private var showFilter: Bool = false
    
    private var isLoading: Bool {
        viewModel.loadingState == .loading
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    ScrollViewReader{ proxy in
                        Color.clear
                            .frame(height: 0)
                            .id("top")
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.shops, id: \.name) { shop in
                                ShopCardView(shop: shop)
                                    .scrollTransition(.interactive) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    }
                                    .redacted(reason: isLoading ? .placeholder : [])
                                    .shimmering(active: isLoading)
                            }
                        }
                        .onChange(of: viewModel.loadingState) { _, newState in
                            if newState == .loaded {
                                withAnimation {
                                    proxy.scrollTo("top", anchor: .top)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .refreshable {
                    await viewModel.fetchShops()
                }
                Button {
                    showFilter = true
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
                .sheet(isPresented: $showFilter) {
                    FilterSheetView(viewModel: viewModel)
                        .presentationDetents([.medium,.large])
                        .presentationBackground(Color(.systemBackground))
                }
            }
            .navigationTitle("付近の店舗")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await viewModel.fetchShops() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}
