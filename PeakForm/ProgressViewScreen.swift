import SwiftUI

struct ProgressViewScreen: View {
    var body: some View {
        VStack {
            Text("Your Progress")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("See how far you've come!")
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Progress")
    }
}

struct ProgressViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewScreen()
    }
}
