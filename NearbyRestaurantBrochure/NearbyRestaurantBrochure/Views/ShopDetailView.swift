import SwiftUI

struct ShopDetailView: View {
    let shop: Shop
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // ヘッダー画像
                headerImage
                
                VStack(alignment: .leading) {
                    
                    // 店舗情報
                    VStack(alignment: .leading) {
                        Text(shop.name ?? "店舗名不明")
                            .font(.title)
                            .bold()
                        
                        // 予算
                        if let budget = shop.budget?.average {
                            Label(budget, systemImage: "yensign.circle")
                                .font(.body)
                                .bold()
                                .foregroundStyle(.orange)
                        }
                    }
                    
                    Divider()
                        .padding(.bottom, 8)
                    
                    // 営業時間・住所・アクセス・地図
                    VStack(alignment: .leading, spacing: 24) {
                        // 営業時間
                        if let open = shop.open {
                            DetailSection(title: "営業時間", icon: "clock", text: open)
                        }
                        
                        if let address = shop.address {
                            DetailSection(title: "住所", icon: "map", text: address)
                        }
                        
                        if let access = shop.access {
                            DetailSection(title: "アクセス", icon: "figure.walk", text: access)
                        }
                        
                        MapView(shop: shop)
                            .frame(height: 240)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.separator, lineWidth: 0.5)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
            }
        }
        .navigationTitle("店舗詳細")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerImage: some View {
        Group {
            if let imageUrlString = shop.photo?.pc?.m ?? shop.photo?.mobile?.l,
               let url = URL(string: imageUrlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle().fill(Color(UIColor.secondarySystemBackground))
                }
                .frame(height: 200)
                .clipped()
            }
        }
    }
}

struct DetailSection: View {
    let title: String
    let icon: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(title)
            }
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundStyle(.orange)
            Text(text)
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
}
