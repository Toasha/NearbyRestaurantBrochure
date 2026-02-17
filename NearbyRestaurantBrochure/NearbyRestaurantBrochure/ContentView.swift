import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("通信テスト")
            .task {
                do {
                    let shops = try await APIClient().fetchShops()
                    
                    print("取得件数:", shops.count)
                    
                    if let first = shops.first {
                        print("最初の店:", first.name ?? "名前なし")
                    }
                    
                    if let second = shops.last {
                        print("最後の店:", second.name ?? "名前なし")
                        print(second.access!)
                    }
                    
                } catch {
                    print("エラー:", error)
                }
            }
    }
}


#Preview {
    ContentView()
}
