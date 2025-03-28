//
//  AvatarView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
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

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                // Username Display & Edit
                HStack {
                    if editingUsername {
                        TextField("Enter new username", text: $newUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
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
                }
                .padding()

                // Character & Gear Slots
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)

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

                // Stats
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
            WeaponSelectionView(selectedGear: $selectedGear, saveAction: saveProfile)
        }
        .sheet(isPresented: $showGearSelection) {
            GearSelectionView(selectedGear: $selectedGear, selectedSlot: $selectedGearSlot, saveAction: saveProfile)
        }
    }

    private func saveProfile() {
        let profile = profiles.first ?? PlayerProfile(context: viewContext)
        profile.username = username
        profile.powerLevel = Int64(powerLevel)
        profile.damage = Int64(damage)
        profile.characterClass = characterClass
        profile.weapon = selectedGear["Weapons"]
        profile.headwear = selectedGear["Headwear"]
        profile.pants = selectedGear["Pants"]
        profile.shoes = selectedGear["Shoes"]

        updateStats()

        do {
            try viewContext.save()
        } catch {
            print("Failed to save profile: \(error)")
        }
    }

    private func updateStats() {
        let gearEffects: [String: (power: Int, damage: Int)] = [
            "Basic Sword": (power: 20, damage: 15),
            "Iron Helmet": (power: 10, damage: 5),
            "Combat Boots": (power: 5, damage: 5),
            "Battle Pants": (power: 10, damage: 7)
        ]

        powerLevel = 100 // Base power level
        damage = 80 // Base damage

        for (_, gear) in selectedGear {
            if let effect = gearEffects[gear] {
                powerLevel += effect.power
                damage += effect.damage
            }
        }

        characterClass = determineClass(powerLevel: powerLevel)
    }

    private func loadProfile() {
        if let profile = profiles.first {
            username = profile.username ?? "Player123"
            powerLevel = Int(profile.powerLevel)
            damage = Int(profile.damage)
            characterClass = profile.characterClass ?? "A"
            selectedGear["Weapons"] = profile.weapon ?? ""
            selectedGear["Headwear"] = profile.headwear ?? ""
            selectedGear["Pants"] = profile.pants ?? ""
            selectedGear["Shoes"] = profile.shoes ?? ""
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
