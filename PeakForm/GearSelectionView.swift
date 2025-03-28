//
//  GearSelectionView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct GearSelectionView: View {
    @Binding var selectedGear: [String: String]
    @Binding var selectedSlot: String
    let saveAction: () -> Void

    let gearOptions: [String: [String]] = [
        "Weapons": ["Basic Sword", "Battle Axe", "Longbow", "Magic Staff"],
        "Headwear": ["Iron Helmet", "Warrior's Bandana", "Mystic Crown"],
        "Pants": ["Battle Pants", "Stealth Trousers", "Mage Robes"],
        "Shoes": ["Combat Boots", "Light Runners", "Mystic Sandals"]
    ]

    var body: some View {
        VStack {
            Text("Select \(selectedSlot)")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            if let options = gearOptions[selectedSlot] {
                List(options, id: \.self) { gear in
                    Button(action: {
                        selectedGear[selectedSlot] = gear
                        saveAction()
                    }) {
                        Text(gear)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

