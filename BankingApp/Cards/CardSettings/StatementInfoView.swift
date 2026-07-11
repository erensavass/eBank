import SwiftUI

struct StatementInfoView: View {
    let cardDetails: [String: String] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "totalLimit": "50000.00",
        "statementBalance": "12000.00"
    ]
    
    let statementPeriod: String = NSLocalizedString("August2024", comment: "")
    let transactions: [String] = [
        NSLocalizedString("Transaction1", comment: "Sample transaction 1"),
        NSLocalizedString("Transaction2", comment: "Sample transaction 2"),
        NSLocalizedString("Transaction3", comment: "Sample transaction 3")
    ]
    
    @State private var showAlert = false
    
    func maskedCardNumber(_ cardNumber: String) -> String {
        let start = cardNumber.prefix(6)
        let end = cardNumber.suffix(4)
        let masked = String(repeating: "*", count: cardNumber.count - 10)
        return "\(start)\(masked)\(end)"
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
                    
                    Text(String(format: NSLocalizedString("TotalLimit", comment: "")+"₺", cardDetails["totalLimit"] ?? ""))
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(String(format: NSLocalizedString("StatementPeriod", comment: ""), statementPeriod))
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        Text(String(format: NSLocalizedString("StatementBalance", comment: "")+"₺", cardDetails["statementBalance"] ?? ""))
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    .padding(.top, 5)
                }
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            Text(NSLocalizedString("My Transactions", comment: ""))
                .font(.headline)
                .padding(.top)
                .padding(.leading)
                .padding(.bottom)
            
            List(transactions, id: \.self) { transaction in
                Text(transaction)
            }
            
            Spacer()
            
            Button(action: {
                showAlert = true
            }) {
                Text(NSLocalizedString("SendEmail", comment: ""))
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(NSLocalizedString("EmailSent", comment: "")), message: Text(NSLocalizedString("EmailNotification", comment: "")), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle(NSLocalizedString("StatementInfoTitle", comment: ""))
    }
}

#Preview {
    StatementInfoView()
}
