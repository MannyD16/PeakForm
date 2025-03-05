import SwiftUI

struct WorkoutTrackingView: View {
    var body: some View {
        VStack {
            Text("Workout Tracking")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Track your workouts here!")
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Workout Tracker")
    }
}

struct WorkoutTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTrackingView()
    }
}
