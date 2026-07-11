import SwiftUI

struct CreditCardDetailView: View {
    var card: CreditCard
    
    let cardDetails: [String: String] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "totalLimit": "50000.00",
        "statementBalance": "12000.00",
        "minimumPayment": "3000.00",
        "remainingStatementBalance": "2500.00",
        "currentTransactions": "15000.00",
        "pendingInstallments": "8500.00",
        "statementDate": "15.09.2024",
        "dueDate": "25.09.2024",
        "nextStatementDate": "25.10.2024"
    ]
    
    @State private var isDetailsExpanded: Bool = false
    
    func formatCardNumber(_ number: String) -> String {
        let start = number.prefix(6)
        let end = number.suffix(4)
        let middle = String(repeating: "*", count: number.count - 10)
        return "\(start)\(middle)\(end)"
    }
    
    var totalLimit: Double {
        Double(cardDetails["totalLimit"] ?? "0.00") ?? 0.00
    }
    
    var remainingStatementBalance: Double {
        Double(cardDetails["remainingStatementBalance"] ?? "0.00") ?? 0.00
    }
    
    var currentTransactions: Double {
        Double(cardDetails["currentTransactions"] ?? "0.00") ?? 0.00
    }
    
    var pendingInstallments: Double {
        Double(cardDetails["pendingInstallments"] ?? "0.00") ?? 0.00
    }
    
    var availableLimit: Double {
        totalLimit - currentTransactions - pendingInstallments - remainingStatementBalance
    }
    
    var totalRemainingDebt: Double {
        remainingStatementBalance + currentTransactions + pendingInstallments
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(cardDetails["cardImage"] ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                
                VStack(alignment: .leading) {
                    Text(cardDetails["cardType"] ?? "")
                        .font(.headline)
                    Text(formatCardNumber(cardDetails["cardNumber"] ?? ""))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(String(format: NSLocalizedString("AvailableLimit", comment: ""), availableLimit))
                        .font(.subheadline)
                        .foregroundColor(.green)
                    Text(String(format: NSLocalizedString("TotalLimit", comment: ""), cardDetails["totalLimit"] ?? ""))
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("StatementInfo", comment: ""))
                    .font(.headline)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading) {
                    Text(String(format: NSLocalizedString("StatementDate", comment: ""), cardDetails["statementDate"] ?? "N/A"))
                    Text(String(format: NSLocalizedString("DueDate", comment: ""), cardDetails["dueDate"] ?? "N/A"))
                    Text(String(format: NSLocalizedString("StatementBalance", comment: "")+"₺", cardDetails["statementBalance"] ?? "0.00"))
                    Text(String(format: NSLocalizedString("MinimumPayment", comment: ""), cardDetails["minimumPayment"] ?? "0.00"))
                    Text(String(format: NSLocalizedString("NextStatementDate", comment: ""), cardDetails["nextStatementDate"] ?? "N/A"))
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            }
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("DebtInfo", comment: ""))
                    .font(.headline)
                    .padding(.bottom, 5)
                
                ExpandableSection(
                    title: String(format: NSLocalizedString("TotalRemainingDebt", comment: ""), totalRemainingDebt),
                    details: [
                        String(format: NSLocalizedString("RemainingStatementBalance", comment: ""), cardDetails["remainingStatementBalance"] ?? "0.00"),
                        String(format: NSLocalizedString("CurrentTransactions", comment: ""), cardDetails["currentTransactions"] ?? "0.00"),
                        String(format: NSLocalizedString("PendingInstallments", comment: "") + ": %@ ₺", cardDetails["pendingInstallments"] ?? "0.00")
                    ],
                    isExpanded: $isDetailsExpanded
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: CreditCardTransactionsView()) {
                Text(NSLocalizedString("CardTransactions", comment: ""))
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle(NSLocalizedString("CreditCardDetailTitle", comment: ""))
    }
}
