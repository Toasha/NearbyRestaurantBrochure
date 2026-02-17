import SwiftUI

struct ShopListView: View {
    
    @ObservedObject var viewModel: ShopListViewModel
    
    var body: some View {
        List(viewModel.shops, id: \.name) { shop in
            
            HStack(alignment: .center, spacing: 12) {
                
                // 店舗画像
                if let imageUrlString = shop.photo?.mobile?.s,
                   let url = URL(string: imageUrlString) {
                    
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 70, height: 70)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(shop.name ?? "店舗名不明")
                        .font(.headline)
                    
                    Text(shop.address ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
            .shadow(color: .black.opacity(0.1),
                    radius: 6,
                    x: 0,
                    y: 3)
            .padding(.vertical, 4)
        }
        .listStyle(.inset)
    }
}

#Preview {
    ShopListView(viewModel: ShopListViewModel())
}
