//
//  WorkoutHistoryView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/16/25.
//

import SwiftUI
import CoreData

struct WorkoutHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: WorkoutSession.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkoutSession.date, ascending: false)]
    ) var workouts: FetchedResults<WorkoutSession>

    @State private var selectedFilter = "All"
    @State private var filterText = ""
    
    let filterOptions = ["All", "Date", "Exercise Type", "Calories Burned"]

    var filteredWorkouts: [WorkoutSession] {
        switch selectedFilter {
        case "Date":
            return workouts.filter { $0.date?.formatted(date: .abbreviated, time: .omitted) == filterText }
        case "Exercise Type":
            return workouts.filter { $0.exerciseType?.lowercased().contains(filterText.lowercased()) ?? false }
        case "Calories Burned":
            if let calories = Int(filterText) {
                return workouts.filter { $0.caloriesBurned == calories }
            }
            return []
        default:
            return Array(workouts)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Workout History")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)

                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if selectedFilter != "All" {
                    TextField("Enter \(selectedFilter)", text: $filterText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                List {
                    ForEach(filteredWorkouts, id: \.self) { workout in
                        VStack(alignment: .leading) {
                            Text(workout.exerciseType ?? "Unknown")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("Calories: \(workout.caloriesBurned) kcal | Duration: \(workout.duration) mins")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text("Date: \(workout.date?.formatted(date: .abbreviated, time: .omitted) ?? "Unknown")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteWorkout(workout)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("Workout History")
        }
    }

    private func deleteWorkout(_ workout: WorkoutSession) {
        viewContext.delete(workout)
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
}

struct WorkoutHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
