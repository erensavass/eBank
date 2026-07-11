import SwiftUI

struct SetPasswordView: View {
    let creditCardDetails: [String: String] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "availableLimit": "24000.00"
    ]
    
    let debitCardDetails: [String: String] = [
        "cardImage": "debitCardImage",
        "cardType": NSLocalizedString("DebitCard", comment: ""),
        "cardNumber": "654321******4321",
        "accountBalance": "3200.50"
    ]
    
    @State private var isCreditCardSelected = true
    @State private var isExpanded = false
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var alertMessage: String? = nil
    @State private var showAlert: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func maskedCardNumber(_ cardNumber: String) -> String {
        let start = cardNumber.prefix(6)
        let end = cardNumber.suffix(4)
        let masked = String(repeating: "*", count: cardNumber.count - 10)
        return "\(start)\(masked)\(end)"
    }
    
    func validatePasswords() {
        if newPassword.count != 4 {
            alertMessage = NSLocalizedString("PasswordMustBe4Digits", comment: "")
            showAlert = true
        } else if newPassword != confirmPassword {
            alertMessage = NSLocalizedString("PasswordMismatchError", comment: "")
            showAlert = true
        } else {
            alertMessage = NSLocalizedString("PasswordChangeSuccess", comment: "")
            showAlert = true
        }
    }
    
    var selectedCardDetails: [String: String] {
        isCreditCardSelected ? creditCardDetails : debitCardDetails
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Kart bilgileri
            HStack(alignment: .top) {
                Image(selectedCardDetails["cardImage"] ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: isCreditCardSelected ? 80 : 120, height: 120) // Dinamik boyut
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(selectedCardDetails["cardType"] ?? "")
                        .font(.headline)
                    
                    Text(maskedCardNumber(selectedCardDetails["cardNumber"] ?? ""))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if isCreditCardSelected, let availableLimitString = selectedCardDetails["availableLimit"],
                       let availableLimit = Double(availableLimitString) {
                        Text(String(format: NSLocalizedString("AvailableLimit", comment: ""), availableLimit))
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    } else if !isCreditCardSelected, let accountBalanceString = selectedCardDetails["accountBalance"],
                              let accountBalance = Double(accountBalanceString) {
                        Text(String(format: NSLocalizedString("AccountBalance", comment: ""), accountBalance))
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                }
            }
            
            // Genişletilebilir kart seçimi
            if isExpanded {
                VStack(alignment: .leading) {
                    if isCreditCardSelected {
                        Button(action: {
                            isCreditCardSelected = false
                            isExpanded = false
                        }) {
                            HStack {
                                Image(debitCardDetails["cardImage"] ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 120) // Banka kartı için geniş boyut
                                    .padding(.trailing)
                                
                                VStack(alignment: .leading) {
                                    Text(debitCardDetails["cardType"] ?? "")
                                        .font(.headline)
                                    
                                    Text(maskedCardNumber(debitCardDetails["cardNumber"] ?? ""))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    } else {
                        Button(action: {
                            isCreditCardSelected = true
                            isExpanded = false
                        }) {
                            HStack {
                                Image(creditCardDetails["cardImage"] ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 120) // Kredi kartı için dar boyut
                                    .padding(.trailing)
                                
                                VStack(alignment: .leading) {
                                    Text(creditCardDetails["cardType"] ?? "")
                                        .font(.headline)
                                    
                                    Text(maskedCardNumber(creditCardDetails["cardNumber"] ?? ""))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            // Şifre belirleme kısmı
            VStack(alignment: .leading, spacing: 10) {
                Text(NSLocalizedString("SetPassword", comment: ""))
                    .font(.headline)
                
                SecureField(NSLocalizedString("NewPassword", comment: ""), text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                SecureField(NSLocalizedString("ConfirmPassword", comment: ""), text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        Text(NSLocalizedString("PasswordMustBe4Digits", comment: ""))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        Text(NSLocalizedString("PasswordRangeNote", comment: ""))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        Text(NSLocalizedString("AvoidBirthdate", comment: ""))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        Text(NSLocalizedString("AvoidSymmetricNumbers", comment: ""))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // Devam butonu
            Button(action: {
                validatePasswords()
            }) {
                Text(NSLocalizedString("Continue", comment: ""))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage ?? ""),
                    dismissButton: .default(Text(NSLocalizedString("OK", comment: ""))) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("SetPasswordTitle", comment: ""))
    }
}

#Preview {
    SetPasswordView()
}
