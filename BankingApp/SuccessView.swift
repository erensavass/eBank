import SwiftUI

struct SuccessView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(NSLocalizedString("SuccessTitle", comment: "Success message title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(NSLocalizedString("WelcomeMessage", comment: "Welcome message"))
                .font(.title2)
                .padding()

            NavigationLink(destination: MenuView()) {
                Text(NSLocalizedString("GoToMenu", comment: "Go to menu button text"))
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
