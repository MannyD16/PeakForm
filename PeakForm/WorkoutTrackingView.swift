import SwiftUI

struct WorkoutTrackingView: View {
    @State private var exerciseName = ""
    @State private var reps = ""
    @State private var sets = ""
    @State private var duration = ""
    @State private var workoutHistory: [(String, String, String, String)] = []

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // 🔥 Futuristic dark background

            VStack(spacing: 20) {
                Text("Workout Tracker")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .shadow(color: .green, radius: 10) // 🔥 Neon glow

                // 🔹 Exercise Name Input
                TextField("Exercise Name", text: $exerciseName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                // 🔹 Reps Input
                TextField("Reps", text: $reps)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                // 🔹 Sets Input
                TextField("Sets", text: $sets)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                // 🔹 Duration Input
                TextField("Duration (minutes)", text: $duration)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                // 🔹 Save Workout Button
                Button(action: saveWorkout) {
                    Text("Save Workout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(color: .green, radius: 10) // 🔥 Neon glow
                }
                .padding(.horizontal)

                // 🔹 Workout History List
                ScrollView {
                    VStack {
                        ForEach(workoutHistory, id: \.0) { workout in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(workout.0)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text("\(workout.1) reps × \(workout.2) sets")
                                        .foregroundColor(.gray)
                                    
                                    Text("\(workout.3) min")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
    }

    // 🔹 Function to Save Workouts
    private func saveWorkout() {
        if !exerciseName.isEmpty, !reps.isEmpty, !sets.isEmpty, !duration.isEmpty {
            workoutHistory.insert((exerciseName, reps, sets, duration), at: 0)
            exerciseName = ""
            reps = ""
            sets = ""
            duration = ""
        }
    }
}

struct WorkoutTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTrackingView()
    }
}

