import SwiftUI

struct AddAccountView: View {
    @Binding var accounts: [Account]
    @Environment(\.dismiss) var dismiss
    
    @State private var accountTypeIndex = 0
    @State private var initialBalance = ""
    @State private var maturityPeriod: Int = 1
    @State private var currencyTypeIndex = 0
    
    private let accountTypes = [
        NSLocalizedString("Checking TL", comment: ""),
        NSLocalizedString("Term TL Account", comment: ""),
        NSLocalizedString("Foreign Currency Account", comment: "")
    ]
    
    private let currencyTypes = [
        NSLocalizedString("Euro", comment: ""),
        NSLocalizedString("Pound", comment: ""),
        NSLocalizedString("Dollar", comment: "")
    ]
    
    private let maturityPeriods = Array(1...12)
    
    var body: some View {
        NavigationStack {
            Form {
                Picker(NSLocalizedString("Account Type", comment: ""), selection: $accountTypeIndex) {
                    ForEach(0..<accountTypes.count, id: \.self) { index in
                        Text(accountTypes[index])
                    }
                }
                
                if accountTypes[accountTypeIndex] == NSLocalizedString("Term TL Account", comment: "") {
                    Picker(NSLocalizedString("Maturity Period (Months)", comment: ""), selection: $maturityPeriod) {
                        ForEach(maturityPeriods, id: \.self) { period in
                            Text("\(period) " + NSLocalizedString("Months", comment: ""))
                        }
                    }
                }
                
                if accountTypes[accountTypeIndex] == NSLocalizedString("Foreign Currency Account", comment: "") {
                    Picker(NSLocalizedString("Currency Type", comment: ""), selection: $currencyTypeIndex) {
                        ForEach(0..<currencyTypes.count, id: \.self) { index in
                            Text(currencyTypes[index])
                        }
                    }
                }
                
                TextField(NSLocalizedString("Initial Balance", comment: ""), text: $initialBalance)
                    .keyboardType(.decimalPad)
                
                Button(NSLocalizedString("Add Account", comment: "")) {
                    if let balance = Double(initialBalance) {
                        let accountType = accountTypes[accountTypeIndex]
                        let currencyType = currencyTypes[currencyTypeIndex]
                        
                        var newAccount = Account(type: accountType, accountNumber: Account.generateAccountNumber(), balance: balance)
                        
                        if accountType == NSLocalizedString("Foreign Currency Account", comment: "") {
                            newAccount.currencyType = currencyType
                        }
                        if accountType == NSLocalizedString("Term TL Account", comment: "") {
                            newAccount.maturityPeriod = maturityPeriod
                        }
                        
                        accounts.append(newAccount)
                        saveAccounts(accounts)
                        dismiss()
                    }
                }
            }
            .navigationTitle(NSLocalizedString("Add New Account", comment: ""))
        }
    }
}
