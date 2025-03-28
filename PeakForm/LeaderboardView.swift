//
//  LeaderboardView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var selectedTab = "Global"
    let tabs = ["Global", "Friends"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 16) {
                    Text("Your Rank: #7")
                        .font(.title2)
                        .foregroundColor(.green)
                        .padding(.top)

                    Picker("Tab", selection: $selectedTab) {
                        ForEach(tabs, id: \ .self) { tab in
                            Text(tab).tag(tab)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    List(1...25, id: \ .self) { rank in
                        HStack {
                            Text("#\(rank)")
                                .foregroundColor(.white)

                            VStack(alignment: .leading) {
                                Text(selectedTab == "Global" ? "GlobalUser\(rank)" : "FriendUser\(rank)")
                                    .foregroundColor(.green)
                                Text("\(Int.random(in: 1000...5000)) PeakPoints")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .listRowBackground(Color.black)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Leaderboard")
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
