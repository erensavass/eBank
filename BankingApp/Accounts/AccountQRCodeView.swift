import SwiftUI
import CoreImage.CIFilterBuiltins

struct AccountsQRCodeView: View {
    @State private var accounts: [Account] = loadAccounts()
    @State private var selectedAccount: Account?
    @State private var qrCodeImage: UIImage?

    var body: some View {
        NavigationStack {
            VStack {
                List(accounts) { account in
                    Button(action: {
                        selectedAccount = account
                        qrCodeImage = generateQRCode(from: account.accountNumber)
                    }) {
                        VStack(alignment: .leading) {
                            Text(account.localizedType)
                            Text("\(NSLocalizedString("Account No: ", comment: "Account number label"))\(account.accountNumber)")
                            Text("\(NSLocalizedString("Balance: ", comment: "Balance label"))\(String(format: "%.2f", account.balance)) ₺")
                        }
                    }
                }
                .navigationTitle(NSLocalizedString("QR Show", comment: "Title for QR code screen"))
                
                if let qrCodeImage = qrCodeImage {
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                }
            }
        }
    }

    func generateQRCode(from string: String) -> UIImage? {
        guard let data = string.data(using: .utf8) else { return nil } 
        let filter = CIFilter.qrCodeGenerator()
        filter.message = data
        let context = CIContext()
        
        if let output = filter.outputImage {
            if let cgImage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}
