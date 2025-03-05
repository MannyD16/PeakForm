import SwiftUI

struct HomeView: View {
    var body: some View { //  Now correctly conforms to View
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Gym Motivation")
                    .font(.title)
                    .fontWeight(.bold)

                NavigationLink(destination: WorkoutTrackingView()) {
                    Text("Start Workout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: ProgressViewScreen()) {
                    Text("View Progress")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: LeaderboardView()) {
                    Text("Leaderboard")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Gym Motivation")
        }
    }
}

//  Add a preview to prevent Xcode errors
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

