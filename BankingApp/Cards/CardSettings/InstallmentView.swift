import SwiftUI

struct InstallmentView: View {
    let cardDetails: [String: String] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "availableLimit": "24000.00"
    ]
    
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
                    
                    Text(String(format: NSLocalizedString("AvailableLimit", comment: "") , Double(cardDetails["availableLimit"]!)!))
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top)
            
            Divider()
            
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
                
                Text(NSLocalizedString("NoInstallmentsAvailable", comment: ""))
                    .font(.headline)
                    .padding(.top)
                
                Text(NSLocalizedString("NoInstallmentMessage", comment: "Taksitlendirilebilir işleminiz bulunmamaktadır."))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("Installments", comment: ""))
    }
}

#Preview {
    InstallmentView()
}
