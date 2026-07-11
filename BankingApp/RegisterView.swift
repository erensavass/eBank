import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSuccessAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(NSLocalizedString("Register", comment: "Register page title"))
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField(NSLocalizedString("Email", comment: "Email field placeholder"), text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField(NSLocalizedString("Password", comment: "Password field placeholder"), text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: register) {
                    Text(NSLocalizedString("SignUp", comment: "Register button text"))
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text(NSLocalizedString("SuccessRegisterTitle", comment: "Success alert title")),
                        message: Text(NSLocalizedString("SuccessMessage", comment: "Success alert message")),
                        dismissButton: .default(Text(NSLocalizedString("SuccessDismiss", comment: "Dismiss button text"))) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
            }
            .padding()
        }
    }

    private func register() {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        
        showSuccessAlert = true
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
