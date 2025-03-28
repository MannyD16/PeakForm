//
//  HomeView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Welcome to PeakForm")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    NavigationLink(destination: WorkoutLogView()) {
                        Text("Start Workout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .green, radius: 10)
                    }

                    NavigationLink(destination: WorkoutProgressView()) {
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
                            .background(Color.purple)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .purple, radius: 10)
                    }

                    NavigationLink(destination: RewardsView()) {
                        Text("Rewards")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .orange, radius: 10)
                    }

                    NavigationLink(destination: Text("Avatar View Coming Soon")) {
                        Text("Avatar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: .red, radius: 10)
                    }
                }
                .padding()
                .navigationTitle("Dashboard")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
