//
//  MainNavigationView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/17/25.
//

import SwiftUI

struct MainNavigationView: View {
    @State private var selectedTab = 2 // Default to Avatar Screen

    var body: some View {
        TabView(selection: $selectedTab) {
            RankView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Rank")
                    }
                }
                .tag(0)

            LobbyView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Lobby")
                    }
                }
                .tag(1)

            AvatarView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Avatar")
                    }
                }
                .tag(2)

            WorkoutView()
                .tabItem {
                    VStack {
                        Image(systemName: "dumbbell.fill")
                        Text("Workout")
                    }
                }
                .tag(3)

            ShopView()
                .tabItem {
                    VStack {
                        Image(systemName: "cart.fill")
                        Text("Shop")
                    }
                }
                .tag(4)
        }
        .accentColor(.green) // Neon green theme
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
