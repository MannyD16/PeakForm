import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("See how you rank against others!")
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Leaderboard")
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
