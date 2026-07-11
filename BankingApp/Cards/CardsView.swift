import SwiftUI

struct CreditCard {
    let cardType: String
    let cardNumber: String
    let totalLimit: Double
    let remainingStatementBalance: Double
    let currentTransactions: Double
    let pendingInstallments: Double
    let cardImage: String
}

struct DebitCard {
    let cardType: String
    let cardNumber: String
    let accountBalance: Double
    let cardImage: String
}

struct CardsView: View {
    var creditCard = CreditCard(
        cardType: NSLocalizedString("CreditCard", comment: ""),
        cardNumber: "1234567890123456",
        totalLimit: 50000.00,
        remainingStatementBalance: 2500.00,
        currentTransactions: 15000.00,
        pendingInstallments: 8500.00,
        cardImage: "creditCardImage"
    )
    
    var debitCard = DebitCard(
        cardType: NSLocalizedString("DebitCard", comment: ""),
        cardNumber: "654321******4321",
        accountBalance: 3200.50,
        cardImage: "debitCardImage"
    )
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text(NSLocalizedString("CreditCardSectionTitle", comment: ""))) {
                    NavigationLink(destination: CreditCardDetailView(card: creditCard)) {
                        HStack {
                            Image(creditCard.cardImage)
                                .resizable()
                                .frame(width: 40, height: 70)
                            VStack(alignment: .leading) {
                                Text(creditCard.cardType)
                                Text(formatCardNumber(creditCard.cardNumber))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                let availableLimit = creditCard.totalLimit - creditCard.currentTransactions - creditCard.pendingInstallments - creditCard.remainingStatementBalance
                                Text(String(format: NSLocalizedString("AvailableLimit", comment: ""), availableLimit))
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                
                Section(header: Text(NSLocalizedString("DebitCardSectionTitle", comment: ""))) {
                    NavigationLink(destination: DebitCardDetailView(card: debitCard)) {
                        HStack {
                            Image(debitCard.cardImage)
                                .resizable()
                                .frame(width: 50, height: 30)
                            VStack(alignment: .leading) {
                                Text(debitCard.cardType)
                                Text(debitCard.cardNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text(String(format: NSLocalizedString("AccountBalance", comment: ""), debitCard.accountBalance))
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("CardsViewTitle", comment: ""))
        }
    }
    
    func formatCardNumber(_ number: String) -> String {
        let start = number.prefix(6)
        let end = number.suffix(4)
        let middle = String(repeating: "*", count: number.count - 10)
        return "\(start)\(middle)\(end)"
    }
}
