//
//  ProfileView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = true

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    // Profile Icon & Username
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.green)
                        Text("PeakForm User")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top, 4)
                    }

                    Form {
                        Section(header: Text("Settings").foregroundColor(.white)) {
                            Toggle(isOn: $notificationsEnabled) {
                                Text("Notifications")
                                    .foregroundColor(.white)
                            }
                            Toggle(isOn: $darkModeEnabled) {
                                Text("Dark Mode")
                                    .foregroundColor(.white)
                            }
                        }
                        .listRowBackground(Color.black)

                        Section(header: Text("App Info").foregroundColor(.white)) {
                            HStack {
                                Text("Version")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("1.0.0")
                                    .foregroundColor(.gray)
                            }
                        }
                        .listRowBackground(Color.black)

                        Section {
                            Button(action: {
                                // Handle logout action
                            }) {
                                Text("Log Out")
                                    .foregroundColor(.red)
                            }
                        }
                        .listRowBackground(Color.black)
                    }
                    .scrollContentBackground(.hidden)
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
