import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            if let key = APIKeyManager.shared.apiKey(for: "Recruit_API_KEY") {
                print("取得成功:", key)
                
                if key.contains("$(") {
                    print("ビルド設定で不備あり")
                }
            } else {
                print("APIキー取得失敗")
            }
        }
    }
}

#Preview {
    ContentView()
}
