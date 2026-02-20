import SwiftUI

struct ShopCardView: View {
    
    let shop: Shop
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // 店舗画像
            if let imageUrlString = shop.photo?.mobile?.l,
               let url = URL(string: imageUrlString) {
                
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 220)
                .clipped()
            }
            
            // 店舗情報
            VStack(alignment: .leading, spacing: 8) {
                Text(shop.name ?? "店舗名不明")
                    .font(.title3)
                    .foregroundStyle(Color(.black))
                    .bold()
                HStack{
                    Image(systemName: "mappin.and.ellipse.circle")
                        .foregroundStyle(Color(.apricot))
                    Text(shop.access ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 3)
    }
}
