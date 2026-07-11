import SwiftUI

struct ContentView: View {
    @State private var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    Text(NSLocalizedString("Welcome", comment: "Welcome message"))
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: RegisterView()) {
                        Text(NSLocalizedString("Register", comment: "Register button text"))
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    
                    NavigationLink(destination: LoginView()) {
                        Text(NSLocalizedString("Login", comment: "Login button text"))
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(NSLocalizedString("DenizBank", comment: "Toolbar title"))
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showLanguageSelection()
                    } label: {
                        Image(systemName: "globe")
                    }
                }
            }
        }
    }

    private func showLanguageSelection() {
        let alertController = UIAlertController(title: NSLocalizedString("Select Language", comment: "Language selection title"), message: nil, preferredStyle: .actionSheet)

        let languages = ["tr": NSLocalizedString("Turkish", comment: "Turkish language"), "en": NSLocalizedString("English", comment: "English language")]

        for (code, name) in languages {
            let action = UIAlertAction(title: name, style: .default) { _ in
                self.setLanguage(code)
            }
            if code == selectedLanguage {
                action.setValue(true, forKey: "checked")
            }
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button"), style: .cancel, handler: nil))

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }

    private func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: NSLocalizedString("LanguageChangedTitle", comment: "Language changed title"),
                message: NSLocalizedString("LanguageChangedMessage", comment: "Language changed message"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK button"), style: .default) { _ in
                exit(0)
            })

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
