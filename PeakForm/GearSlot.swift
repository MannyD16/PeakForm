//
//  GearSlot.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct GearSlot: View {
    let title: String
    @Binding var selectedGear: [String: String]
    @Binding var showGearSelection: Bool
    @Binding var selectedSlot: String

    var body: some View {
        VStack {
            Image(systemName: selectedGear[title] != "" ? "checkmark.circle.fill" : "circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(selectedGear[title] != "" ? .green : .gray)
                .onTapGesture {
                    selectedSlot = title
                    showGearSelection = true
                }
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding()
    }
}
