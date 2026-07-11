import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(NSLocalizedString("LoginTitle", comment: "Login page title"))
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField(NSLocalizedString("EmailPlaceholder", comment: "Email field placeholder"), text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField(NSLocalizedString("PasswordPlaceholder", comment: "Password field placeholder"), text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: login) {
                    Text(NSLocalizedString("LoginButton", comment: "Login button text"))
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $showError) {
                    Alert(title: Text(NSLocalizedString("ErrorTitle", comment: "Error alert title")), message: Text(NSLocalizedString("ErrorMessage", comment: "Error alert message")), dismissButton: .default(Text(NSLocalizedString("Dismiss", comment: "Dismiss button text")))
                    )
                }

                NavigationLink(destination: ForgotPassView()) {
                    Text(NSLocalizedString("ForgotPasswordLink", comment: "Forgot password link text"))
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                SuccessView()
            }
        }
    }

    private func login() {
        let storedEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let storedPassword = UserDefaults.standard.string(forKey: "password") ?? ""

        if email == storedEmail && password == storedPassword {
            isLoggedIn = true
        } else {
            showError = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
