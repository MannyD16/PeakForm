//
//  WorkoutLogView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI

struct WorkoutLogView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var exerciseType: String = ""
    @State private var duration: String = ""
    @State private var caloriesBurned: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Log Your Workout")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    TextField("Exercise Type (e.g. Pushups, Running)", text: $exerciseType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    TextField("Duration (minutes)", text: $duration)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    TextField("Calories Burned", text: $caloriesBurned)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    Button(action: saveWorkout) {
                        Text("Save Workout")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    .alert("Workout Saved", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {}
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Log Workout")
        }
    }

    private func saveWorkout() {
        guard let durationInt = Int(duration),
              let caloriesInt = Int(caloriesBurned),
              !exerciseType.isEmpty else { return }

        let newWorkout = WorkoutSession(context: viewContext)
        newWorkout.id = UUID()
        newWorkout.date = Date()
        newWorkout.duration = Int64(durationInt)
        newWorkout.caloriesBurned = Int64(caloriesInt)
        newWorkout.exerciseType = exerciseType
        newWorkout.powerLevel = Int64(0) // Placeholder

        do {
            try viewContext.save()
            showAlert = true
            exerciseType = ""
            duration = ""
            caloriesBurned = ""
        } catch {
            print("Error saving workout: \(error.localizedDescription)")
        }
    }
}

struct WorkoutLogView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
