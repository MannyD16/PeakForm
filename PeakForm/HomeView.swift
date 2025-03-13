import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) //  Black background
                
                VStack(spacing: 20) {
                    Text("Welcome to Gym Motivation")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 10) //  Glow effect
                    
                    NavigationLink(destination: WorkoutTrackingView()) {
                        Text("Start Workout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green) //  Use neon green or red here
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .green, radius: 10) //  Glow effect
                    }
                    
                    NavigationLink(destination: ProgressViewScreen()) {
                        Text("View Progress")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .blue, radius: 10)
                    }

                    NavigationLink(destination: LeaderboardView()) {
                        Text("Leaderboard")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .orange, radius: 10)
                    }
                }
                .padding()
                .navigationTitle("Gym Motivation")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

