import SwiftUI

struct ForgotPassView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text(NSLocalizedString("ForgotPassword", comment: "Forgot password page title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField(NSLocalizedString("Email", comment: "Email field placeholder"), text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            Button(action: sendResetLink) {
                Text(NSLocalizedString("SendLink", comment: "Send link button text"))
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(NSLocalizedString("Status", comment: "Status alert title")), message: Text(alertMessage), dismissButton: .default(Text(NSLocalizedString("Dismiss", comment: "Dismiss button text")))
                )
            }
        }
        .padding()
    }

    private func sendResetLink() {
        let storedEmail = UserDefaults.standard.string(forKey: "email") ?? ""

        if email == storedEmail {
            alertMessage = NSLocalizedString("LinkSent", comment: "Link sent success message")
        } else {
            alertMessage = NSLocalizedString("EmailNotRegistered", comment: "Email not registered error message")
        }
        showAlert = true
    }
}

struct ForgotPassView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassView()
    }
}
