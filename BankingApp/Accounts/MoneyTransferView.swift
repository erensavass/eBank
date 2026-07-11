import SwiftUI

struct MoneyTransferView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSourceType: String = NSLocalizedString("Account", comment: "")
    @State private var selectedAccount: Account? = nil
    @State private var iban: String = ""
    @State private var recipientName: String = ""
    @State private var transferDate: Date = Date()
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var showAlert = false
    @State private var showSuccessAlert = false
    @State private var accounts: [Account] = loadAccounts()
    
    // Credit card details
    let creditCardDetails: [String: Any] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "availableLimit": 24000.00 // Burayı Double olarak güncelledik
    ]
    
    // Installment selection state
    @State private var isInstallment: Bool = false
    @State private var selectedInstallments: Int = 3
    private let installmentOptions = [1, 2, 3, 4, 5]

    var body: some View {
        ScrollView { // ScrollView ekledik
            VStack(alignment: .center, spacing: 20) {
                // Source selection
                Picker(NSLocalizedString("SourceSelection", comment: ""), selection: $selectedSourceType) {
                    Text(NSLocalizedString("Account", comment: "")).tag(NSLocalizedString("Account", comment: ""))
                    Text(NSLocalizedString("Card", comment: "")).tag(NSLocalizedString("Card", comment: ""))
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity)

                if selectedSourceType == NSLocalizedString("Account", comment: "") {
                    // Account selection
                    Menu {
                        ForEach(accounts) { account in
                            Button(account.localizedType) {
                                selectedAccount = account
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedAccount?.localizedType ?? NSLocalizedString("SelectAccount", comment: ""))
                                .foregroundColor(selectedAccount == nil ? .gray : .black)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)

                    if let account = selectedAccount {
                        Text("\(NSLocalizedString("Balance", comment: "")): \(String(format: "%.2f", account.balance)) ₺")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                } else {
                    // Credit card display
                    HStack {
                        Image(creditCardDetails["cardImage"] as? String ?? "")
                            .resizable()
                            .frame(width: 80, height: 120)
                            .padding(.trailing)

                        VStack(alignment: .leading) {
                            Text(creditCardDetails["cardType"] as? String ?? "")
                                .font(.headline)

                            Text(maskedCardNumber(creditCardDetails["cardNumber"] as? String ?? ""))
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            let availableLimit = creditCardDetails["availableLimit"] as? Double ?? 0.00
                            Text(String(format: "\(NSLocalizedString("AvailableLimit", comment: ""))", availableLimit))
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                
                // Recipient Information
                VStack(alignment: .leading, spacing: 10) {
                    Text(NSLocalizedString("RecipientInformation", comment: ""))
                        .font(.headline)
                    
                    TextField(NSLocalizedString("IBAN", comment: ""), text: $iban)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.asciiCapable)
                    
                    TextField(NSLocalizedString("RecipientName", comment: ""), text: $recipientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal) // Padding added to align edges

                // Transaction Information
                VStack(alignment: .leading, spacing: 10) {
                    Text(NSLocalizedString("TransactionInformation", comment: ""))
                        .font(.headline)
                    
                    DatePicker(NSLocalizedString("Date", comment: ""), selection: $transferDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                    
                    TextField(NSLocalizedString("Amount", comment: ""), text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextField(NSLocalizedString("Description", comment: ""), text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal) // Padding added to align edges
                
                // Installment option
                if selectedSourceType == NSLocalizedString("Card", comment: "") {
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle(NSLocalizedString("WouldYouLikeToSplitIntoInstallments", comment: ""), isOn: $isInstallment)
                            .padding(.vertical, 10)
                            .toggleStyle(SwitchToggleStyle(tint: .blue)) // Custom toggle style
                            .padding(.horizontal)

                        if isInstallment {
                            VStack {
                                Text(NSLocalizedString("SelectInstallments", comment: ""))
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                
                                Picker("", selection: $selectedInstallments) {
                                    ForEach(installmentOptions, id: \.self) { option in
                                        Text("\(option) \(NSLocalizedString("Installments", comment: ""))")
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)
                                .padding(5)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .padding(.top, 10)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Send Money Button
                Button(action: {
                    if iban.isEmpty || recipientName.isEmpty || amount.isEmpty {
                        showAlert = true
                    } else {
                        showSuccessAlert = true
                    }
                }) {
                    Text(NSLocalizedString("SendMoney", comment: ""))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.headline)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(NSLocalizedString("Error", comment: "")),
                        message: Text(NSLocalizedString("PleaseFillAllFields", comment: "")),
                        dismissButton: .default(Text(NSLocalizedString("OK", comment: "")))
                    )
                }
                .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text(NSLocalizedString("Success", comment: "")),
                        message: Text(NSLocalizedString("TransferSuccessMessage", comment: "")),
                        dismissButton: .default(Text(NSLocalizedString("OK", comment: ""))) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
                .padding(.horizontal) // Padding added for alignment
            }
            .padding() // Padding for the main container
            .navigationTitle(NSLocalizedString("MoneyTransfer", comment: ""))
            .onAppear {
                accounts = loadAccounts()
            }
        }
    }
    
    func maskedCardNumber(_ cardNumber: String) -> String {
        let start = cardNumber.prefix(6)
        let end = cardNumber.suffix(4)
        let masked = String(repeating: "*", count: cardNumber.count - 10)
        return "\(start)\(masked)\(end)"
    }
}

#Preview {
    MoneyTransferView()
}
