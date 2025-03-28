//
//  WeaponSelectionView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct WeaponSelectionView: View {
    @Binding var selectedGear: [String: String]
    let saveAction: () -> Void

    let weapons = ["Basic Sword", "Battle Axe", "Longbow", "Magic Staff"]

    var body: some View {
        VStack {
            Text("Select Your Preferred Weapon")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            List(weapons, id: \.self) { weapon in
                Button(action: {
                    selectedGear["Weapons"] = weapon
                    saveAction()
                }) {
                    Text(weapon)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
