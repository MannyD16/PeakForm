//
//  SplashScreenView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.green)

                Text("PeakForm")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Level Up Your Fitness")
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }
            .opacity(isActive ? 0 : 1)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            HomeView()
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
