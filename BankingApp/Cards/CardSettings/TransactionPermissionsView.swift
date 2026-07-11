import SwiftUI

struct TransactionPermissionsView: View {
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
    @State private var internetTransactions = true
    @State private var phoneMailOrders = true
    @State private var contactlessPayments = true
    @State private var foreignTransactions = true
    
    func maskedCardNumber(_ cardNumber: String) -> String {
        let start = cardNumber.prefix(6)
        let end = cardNumber.suffix(4)
        let masked = String(repeating: "*", count: cardNumber.count - 10)
        return "\(start)\(masked)\(end)"
    }
    
    var selectedCardDetails: [String: String] {
        isCreditCardSelected ? creditCardDetails : debitCardDetails
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(selectedCardDetails["cardImage"] ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: isCreditCardSelected ? 80 : 120, height: isCreditCardSelected ? 120 : 120) // Banka kartı genişliğini 120 yap
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
            
            // İşlem izinleri
            Divider()
            Text(NSLocalizedString("TransactionPermissions", comment: ""))
                .font(.headline)
                .padding(.bottom)
                .padding(.top)
            
            Toggle(NSLocalizedString("InternetTransactions", comment: ""), isOn: $internetTransactions)
                .toggleStyle(SwitchToggleStyle())
                .padding(.bottom)
            
            Toggle(NSLocalizedString("PhoneMailOrders", comment: ""), isOn: $phoneMailOrders)
                .toggleStyle(SwitchToggleStyle())
                .padding(.bottom)
            
            Toggle(NSLocalizedString("ContactlessPayments", comment: ""), isOn: $contactlessPayments)
                .toggleStyle(SwitchToggleStyle())
                .padding(.bottom)
            
            Toggle(NSLocalizedString("ForeignTransactions", comment: ""), isOn: $foreignTransactions)
                .toggleStyle(SwitchToggleStyle())
            
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("TransactionPermissionsTitle", comment: ""))
    }
}

#Preview {
    TransactionPermissionsView()
}
