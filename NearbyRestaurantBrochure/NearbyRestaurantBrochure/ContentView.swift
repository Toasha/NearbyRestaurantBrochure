import SwiftUI

struct ContentView: View {
    
    let locationManager = LocationManager()
    
    var body: some View {
        Text("")
            .onAppear {
                locationManager.startUpdating()
            }
    }
}



#Preview {
    ContentView()
}
