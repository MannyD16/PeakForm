//
//  WorkoutProgressView.swift
//  PeakForm
//
//  Created by Manuel Diaz on 3/17/25.
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
        let totalCalories = filteredWorkouts.reduce(0) { $0 + Int($1.caloriesBurned) }
        return filteredWorkouts.isEmpty ? 0 : totalCalories / filteredWorkouts.count
    }
    
    var averagePowerLevel: Int {
        let totalPower = filteredWorkouts.reduce(0) { $0 + Int($1.powerLevel) }
        return filteredWorkouts.isEmpty ? 0 : totalPower / filteredWorkouts.count
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Workout Progress")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        
                    Picker("Time Frame", selection: $selectedTimeFrame) {
                        ForEach(timeFrames, id: \ .self) { frame in
                            Text(frame).tag(frame)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if filteredWorkouts.isEmpty {
                        Text("No Workout Data Available")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Bar Chart - Calories Burned per Day
                        Chart {
                            ForEach(filteredWorkouts, id: \ .self) { workout in
                                BarMark(
                                    x: .value("Date", workout.date ?? Date(), unit: .day),
                                    y: .value("Calories", workout.caloriesBurned)
                                )
                                .foregroundStyle(Color.green)
                                .animation(.easeInOut(duration: 0.5), value: filteredWorkouts.count)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                        // Line Graph - Power Level Progression
                        Chart {
                            ForEach(filteredWorkouts, id: \ .self) { workout in
                                LineMark(
                                    x: .value("Date", workout.date ?? Date(), unit: .day),
                                    y: .value("Power Level", workout.powerLevel)
                                )
                                .foregroundStyle(Color.blue)
                                .animation(.easeInOut(duration: 0.5), value: filteredWorkouts.count)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                        // Detailed Stats Section
                        VStack(spacing: 10) {
                            Text("Detailed Stats")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top)
                            
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
        }
    }
}

struct WorkoutProgressView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutProgressView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

