//
//  AvatarView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/17/25.
//

import SwiftUI
import CoreData

struct AvatarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PlayerProfile.entity(), sortDescriptors: []) var profiles: FetchedResults<PlayerProfile>
    
    @State private var username: String = "Player123"
    @State private var powerLevel: Int = 100
    @State private var damage: Int = 80
    @State private var characterClass: String = "A"
    @State private var selectedGear: [String: String] = ["Weapons": "", "Headwear": "", "Pants": "", "Shoes": ""]
    @State private var showGearSelection = false
    @State private var editingUsername = false
    @State private var newUsername = ""
    @State private var selectedGearSlot: String = ""
    @State private var showWeaponSelection = false
    @State private var weaponAnimationTrigger = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Username Display with Edit Option
                HStack {
                    if editingUsername {
                        TextField("Enter new username", text: $newUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .shadow(color: .white, radius: 5)
                            .foregroundColor(.white)
                        Button("Save") {
                            username = newUsername
                            saveProfile()
                            editingUsername = false
                        }
                        .foregroundColor(.green)
                    } else {
                        Text(username)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .shadow(color: .white, radius: 5)
                        Button(action: { editingUsername = true }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.green)
                        }
                    }
                }
                
                // Preferred Weapon Selection
                Button(action: { showWeaponSelection = true }) {
                    Text("Select Preferred Weapon")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: .blue, radius: 10)
                }
                .padding()
                
                // Weapon Preview with Glow Animation
                if let weapon = selectedGear["Weapons"], !weapon.isEmpty {
                    Text("Equipped Weapon: \(weapon)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .shadow(color: weaponAnimationTrigger ? .green : .clear, radius: 10)
                        .animation(.easeInOut(duration: 0.5), value: weaponAnimationTrigger)
                        .onAppear {
                            weaponAnimationTrigger.toggle()
                        }
                }
                
                // Character Avatar & Gear Slots
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .shadow(color: .white, radius: 10)
                        
                    HStack {
                        GearSlot(title: "Weapons", selectedGear: $selectedGear, showGearSelection: $showGearSelection, selectedSlot: $selectedGearSlot)
                        GearSlot(title: "Headwear", selectedGear: $selectedGear, showGearSelection: $showGearSelection, selectedSlot: $selectedGearSlot)
                    }
                    HStack {
                        GearSlot(title: "Pants", selectedGear: $selectedGear, showGearSelection: $showGearSelection, selectedSlot: $selectedGearSlot)
                        GearSlot(title: "Shoes", selectedGear: $selectedGear, showGearSelection: $showGearSelection, selectedSlot: $selectedGearSlot)
                    }
                }
                .padding()
                
                // Character Stats
                VStack {
                    HStack {
                        StatBox(title: "Power LVL", value: "\(powerLevel)")
                        StatBox(title: "Damage", value: "\(damage)")
                        StatBox(title: "Class", value: characterClass)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .onAppear(perform: loadProfile)
        }
        .sheet(isPresented: $showWeaponSelection) {
            WeaponSelectionView(selectedGear: $selectedGear, saveAction: {
                saveProfile()
                weaponAnimationTrigger.toggle()
            })
        }
        .sheet(isPresented: $showGearSelection) {
            GearSelectionView(selectedGear: $selectedGear, selectedSlot: $selectedGearSlot, saveAction: saveProfile)
        }
    }
}
