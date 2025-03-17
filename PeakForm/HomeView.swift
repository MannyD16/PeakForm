import SwiftUI

struct HomeView: View {
    @State private var peakPoints: Int = 1200 // Placeholder value
    @State private var workoutStreak: Int = 7 // Placeholder value

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) // Black background
                
                VStack(spacing: 20) {
                    // PeakPoints and Streak Tracking
                    VStack {
                        Text("PeakPoints: \(peakPoints)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .shadow(color: .green, radius: 5)
                        
                        Text("Workout Streak: \(workoutStreak) Days")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                    // Quick Actions
                    HStack(spacing: 20) {
                        NavigationLink(destination: WorkoutView()) {
                            DashboardButton(title: "Start Workout", icon: "dumbbell.fill", color: .blue)
                        }
                        
                        NavigationLink(destination: RankView()) {
                            DashboardButton(title: "Leaderboard", icon: "chart.bar.fill", color: .purple)
                        }
                    }

                    HStack(spacing: 20) {
                        NavigationLink(destination: RewardsView()) {
                            DashboardButton(title: "Claim Rewards", icon: "gift.fill", color: .orange)
                        }
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Dashboard")
            }
        }
    }
}

struct DashboardButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Circle())
                .shadow(color: color, radius: 5)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

