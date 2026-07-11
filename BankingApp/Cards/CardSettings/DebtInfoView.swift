import SwiftUI

struct DebtInfoView: View {
    let cardDetails: [String: String] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "availableLimit": "24000.00",
        "statementBalance": "12000.00"
    ]
    
    @State private var selectedOption: String? = NSLocalizedString("TransactionsInPeriod", comment: "")
    @State private var totalAmount: String = NSLocalizedString("TotalAmountInPeriod", comment: "") + ": 15000 ₺"
    
    let transactionsInPeriod: [String] = [
        NSLocalizedString("Transaction1", comment: "Sample transaction 1"),
        NSLocalizedString("Transaction2", comment: "Sample transaction 2"),
        NSLocalizedString("Transaction3", comment: "Sample transaction 3")
    ]
    
    let pendingInstallments: [String] = [
        NSLocalizedString("PendingInstallment1", comment: "Sample pending installment 1"),
        NSLocalizedString("PendingInstallment2", comment: "Sample pending installment 2")
    ]
    
    func maskedCardNumber(_ cardNumber: String) -> String {
        let start = cardNumber.prefix(6)
        let end = cardNumber.suffix(4)
        let masked = String(repeating: "*", count: cardNumber.count - 10)
        return "\(start)\(masked)\(end)"
    }
    
    func updateView(for option: String) {
        switch option {
        case NSLocalizedString("TransactionsInPeriod", comment: ""):
            selectedOption = NSLocalizedString("TransactionsInPeriod", comment: "")
            totalAmount = NSLocalizedString("TotalAmountInPeriod", comment: "") + ": 15000 ₺"
        case NSLocalizedString("PendingInstallments", comment: ""):
            selectedOption = NSLocalizedString("PendingInstallments",  comment: "")
            totalAmount = NSLocalizedString("TotalPendingInstallments", comment: "") + ": 8500 ₺"
        default:
            selectedOption = nil
            totalAmount = ""
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(cardDetails["cardImage"] ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 120)
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(cardDetails["cardType"] ?? "")
                        .font(.headline)
                    
                    Text(maskedCardNumber(cardDetails["cardNumber"] ?? ""))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if let availableLimitString = cardDetails["availableLimit"],
                       let availableLimit = Double(availableLimitString) {
                        Text(String(format: NSLocalizedString("AvailableLimit", comment: "") , availableLimit))
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                    
                    Text(String(format: NSLocalizedString("StatementBalance", comment: "") + " ₺", cardDetails["statementBalance"] ?? ""))
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
            .padding(.top)
            
            Divider()
            
            HStack {
                Button(action: {
                    updateView(for: NSLocalizedString("TransactionsInPeriod", comment: ""))
                }) {
                    Text(NSLocalizedString("TransactionsInPeriod", comment: ""))
                        .font(.footnote)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == NSLocalizedString("TransactionsInPeriod", comment: "") ? Color.gray.opacity(0.3) : Color.clear)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    updateView(for: NSLocalizedString("PendingInstallments", comment: ""))
                }) {
                    Text(NSLocalizedString("PendingInstallments", comment: ""))
                        .font(.footnote)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == NSLocalizedString("PendingInstallments", comment: "") ? Color.gray.opacity(0.3) : Color.clear)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            if let selectedOption = selectedOption {
                VStack(alignment: .leading) {
                    Text(selectedOption)
                        .font(.headline)
                        .padding(.top)
                    
                    Text(totalAmount)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                Divider()
                
                List {
                    if selectedOption == NSLocalizedString("TransactionsInPeriod", comment: "") {
                        ForEach(transactionsInPeriod, id: \.self) { transaction in
                            Text(transaction)
                        }
                    } else if selectedOption == NSLocalizedString("PendingInstallments", comment: "") {
                        ForEach(pendingInstallments, id: \.self) { installment in
                            Text(installment)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: 300)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("DebtInfoTitle", comment: ""))
    }
}

#Preview {
    DebtInfoView()
}
