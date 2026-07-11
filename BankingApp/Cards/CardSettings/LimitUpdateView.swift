import SwiftUI

struct LimitUpdateView: View {
    let cardDetails: [String: String] = [
        "cardImage": "creditCardImage",
        "cardType": NSLocalizedString("CreditCard", comment: ""),
        "cardNumber": "1234567890123456",
        "availableLimit": "24000.00"
    ]
    
    @State private var currentLimit: String = "50000.00"
    @State private var requestedLimit: String = ""
    @State private var declaredIncome: String = ""
    @State private var showAlert: Bool = false
    
    func maskedCardNumber(_ cardNumber: String) -> String {
        let start = cardNumber.prefix(6)
        let end = cardNumber.suffix(4)
        let masked = String(repeating: "*", count: cardNumber.count - 10)
        return "\(start)\(masked)\(end)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Kart Bilgileri En Üstte
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
                        Text(String(format: NSLocalizedString("AvailableLimit", comment: ""), availableLimit))
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.bottom, -70)
            .padding(.top, 20)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("CurrentLimit", comment: ""))
                        .font(.headline)
                    Text("\(currentLimit) ₺")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("RequestedLimit", comment: ""))
                        .font(.headline)
                    TextField(NSLocalizedString("EnterRequestedLimit", comment: ""), text: $requestedLimit)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("DeclaredIncome", comment: ""))
                        .font(.headline)
                    TextField(NSLocalizedString("EnterDeclaredIncome", comment: ""), text: $declaredIncome)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    showAlert = true
                }) {
                    Text(NSLocalizedString("Continue", comment: ""))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(NSLocalizedString("RequestReceived", comment: "")), message: nil, dismissButton: .default(Text(NSLocalizedString("OK", comment: ""))))
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("LimitUpdate", comment: ""))
    }
}

#Preview {
    LimitUpdateView()
}
