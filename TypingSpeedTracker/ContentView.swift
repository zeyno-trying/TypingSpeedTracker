import SwiftUI

struct ContentView: View {
    var body: some View {
        
            NavigationStack{
                ZStack{
                    Image("onboarding")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    VStack {
                             Spacer()
                             NavigationLink("Start the Test —>") {
                                 TestLogic()
                             }
                             .fontWeight(.black)
                             .font(.largeTitle)
                             .foregroundColor(.white)

                         }
                   
                }
            }
        
    }
}

#Preview {
    ContentView()
}
