//
//  RewardsView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct RewardsView: View {
    @State private var peakPoints = 3250

    let rewards = [
        ("10% Off Protein", 1000),
        ("Free Shaker Bottle", 2000),
        ("25% Off Gym Gear", 3000),
        ("Free Month Gym Membership", 5000)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 16) {
                    Text("Your PeakPoints: \(peakPoints)")
                        .font(.title2)
                        .foregroundColor(.green)
                        .padding(.top)

                    List(rewards, id: \ .0) { reward in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(reward.0)
                                    .foregroundColor(.white)
                                Text("Cost: \(reward.1) Points")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if peakPoints >= reward.1 {
                                Button("Redeem") {
                                    peakPoints -= reward.1
                                }
                                .padding(6)
                                .background(Color.green)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                            } else {
                                Text("Not Enough")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        .listRowBackground(Color.black)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Rewards")
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
