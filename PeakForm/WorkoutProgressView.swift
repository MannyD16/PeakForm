//
//  WorkoutProgressView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/27/25.
//

import SwiftUI
import Charts
import CoreData

struct WorkoutProgressView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: WorkoutSession.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkoutSession.date, ascending: true)]
    ) var workouts: FetchedResults<WorkoutSession>

    @State private var selectedTimeFrame: String = "Weekly"
    let timeFrames = ["Weekly", "Monthly"]

    var filteredWorkouts: [WorkoutSession] {
        let calendar = Calendar.current
        let now = Date()
        return workouts.filter { workout in
            if selectedTimeFrame == "Weekly" {
                return calendar.isDate(workout.date ?? Date(), equalTo: now, toGranularity: .weekOfYear)
            } else {
                return calendar.isDate(workout.date ?? Date(), equalTo: now, toGranularity: .month)
            }
        }
    }

    var averageCaloriesBurned: Int {
        let total = filteredWorkouts.reduce(0) { $0 + Int($1.caloriesBurned) }
        return filteredWorkouts.isEmpty ? 0 : total / filteredWorkouts.count
    }

    var averagePowerLevel: Int {
        let total = filteredWorkouts.reduce(0) { $0 + Int($1.powerLevel) }
        return filteredWorkouts.isEmpty ? 0 : total / filteredWorkouts.count
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 16) {
                    Text("Workout Progress")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Picker("Time Frame", selection: $selectedTimeFrame) {
                        ForEach(timeFrames, id: \ .self) { frame in
                            Text(frame).tag(frame)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    if filteredWorkouts.isEmpty {
                        Text("No Workout Data Available")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        Chart {
                            ForEach(filteredWorkouts, id: \ .self) { workout in
                                BarMark(
                                    x: .value("Date", workout.date ?? Date(), unit: .day),
                                    y: .value("Calories", workout.caloriesBurned)
                                )
                                .foregroundStyle(Color.green)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                        Chart {
                            ForEach(filteredWorkouts, id: \ .self) { workout in
                                LineMark(
                                    x: .value("Date", workout.date ?? Date(), unit: .day),
                                    y: .value("Power Level", workout.powerLevel)
                                )
                                .foregroundStyle(Color.blue)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                        VStack(spacing: 10) {
                            Text("Detailed Stats")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("Average Calories Burned: \(averageCaloriesBurned) kcal")
                                .foregroundColor(.green)

                            Text("Average Power Level: \(averagePowerLevel)")
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Progress")
        }
    }
}

struct WorkoutProgressView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutProgressView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
