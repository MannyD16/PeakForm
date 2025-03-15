//
//  WorkoutLogView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/15/25.
//

import SwiftUI

struct WorkoutLogView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var exerciseType: String = ""
    @State private var duration: String = ""
    @State private var caloriesBurned: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Log Your Workout")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                TextField("Exercise Type (e.g., Running, Lifting)", text: $exerciseType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Duration (minutes)", text: $duration)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                TextField("Calories Burned", text: $caloriesBurned)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                Button(action: saveWorkout) {
                    Text("Save Workout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Workout Saved"), message: Text("Your workout has been logged successfully!"), dismissButton: .default(Text("OK")))
                }

                Spacer()
            }
            .padding()
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

        do {
            try viewContext.save()
            showAlert = true
            // Reset fields after saving
            exerciseType = ""
            duration = ""
            caloriesBurned = ""
        } catch {
            print("Failed to save workout: \(error)")
        }
    }
}

struct WorkoutLogView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
