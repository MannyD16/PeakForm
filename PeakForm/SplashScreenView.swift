import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var caloriesBurned: Double = 0

    var body: some View {
        if isActive {
            HomeView() // Navigates to HomeView after the splash screen
        } else {
            VStack {
                Image(systemName: "flame.fill") // Replace with your logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)

                Text("Peak Form") // Updated app name
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Calories Burned Today: \(caloriesBurned, specifier: "%.0f") kcal")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .ignoresSafeArea()
            .onAppear {
                // Request Apple Health permissions and fetch calorie data
                HealthManager.shared.requestAuthorization { success, error in
                    if success {
                        HealthManager.shared.fetchCaloriesBurned { calories in
                            DispatchQueue.main.async {
                                self.caloriesBurned = calories
                            }
                        }
                    }
                }

                // Navigate to HomeView after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


