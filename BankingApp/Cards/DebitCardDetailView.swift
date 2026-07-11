import SwiftUI

struct DebitCardDetailView: View {
    var card: DebitCard

    let transactions: [String] = [
        NSLocalizedString("Transaction1", comment: ""),
        NSLocalizedString("Transaction2", comment: ""),
        NSLocalizedString("Transaction3", comment: "")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                
                VStack(alignment: .leading) {
                    Text(card.cardType)
                        .font(.headline)
                    Text(String(format: NSLocalizedString("CardNumber", comment: ""), card.cardNumber))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(String(format: NSLocalizedString("AccountBalance", comment: ""), card.accountBalance))
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding()

            Divider()

            Text(NSLocalizedString("TransactionsTitle", comment: ""))
                .font(.headline)
                .padding(.horizontal)

            List(transactions, id: \.self) { transaction in
                Text(transaction)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .navigationTitle(NSLocalizedString("DebitCardDetailTitle", comment: ""))
    }
}

#Preview {
    DebitCardDetailView(card: DebitCard(cardType: "Debit Card", cardNumber: "654321******4321", accountBalance: 3200.50, cardImage: "debitCardImage"))
}
