import SwiftUI

struct AccountDetailView: View {
    @Binding var accounts: [Account]
    var account: Account
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("\(NSLocalizedString("Account Type", comment: "")): \(account.localizedType)")
                .font(.headline)
            
            Text("\(NSLocalizedString("Account No", comment: "")): \(account.accountNumber)")
                .font(.subheadline)
            
            Text("\(NSLocalizedString("Balance", comment: "")): \(String(format: "%.2f", account.balance)) ₺")
                .font(.title)
                .padding()
            
            Text(NSLocalizedString("My Transactions", comment: ""))
                .font(.headline)
                .padding(.top)
            
            List(account.transactions, id: \.self) { transaction in
                Text(transaction)
            }
            
            Button(action: {
                if let index = accounts.firstIndex(where: { $0.id == account.id }) {
                    accounts.remove(at: index)
                    saveAccounts(accounts)
                    dismiss()
                }
            }) {
                Text(NSLocalizedString("Delete Account", comment: ""))
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("Account Details", comment: ""))
    }
}
