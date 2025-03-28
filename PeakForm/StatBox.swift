//
//  StatBox.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct StatBox: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .shadow(color: .green, radius: 5)
        }
        .frame(width: 100, height: 80)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
