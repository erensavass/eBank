import SwiftUI

struct CreditApplicationView: View {
    @State private var creditAmount: String = ""
    @State private var selectedInstallments: Int = 12
    @State private var showSuccessAlert = false
    @State private var showInstallmentsSheet = false
    @State private var showErrorAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "gift")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                
                Text(String(format: NSLocalizedString("PreApprovedLimit", comment: "Pre-approved credit limit message"), "50.000 TL"))
                    .font(.headline)
                    .fontWeight(.bold)
            }
     
            VStack(alignment: .leading) {
                Text(NSLocalizedString("CreditAmount", comment: "Requested credit amount label"))
                    .font(.subheadline)
                
                TextField(NSLocalizedString("EnterCreditAmount", comment: "Placeholder for entering credit amount"), text: $creditAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Installments", comment: "Installments label"))
                    .font(.subheadline)
                
                Button(action: {
                    showInstallmentsSheet = true
                }) {
                    Text("\(selectedInstallments) " + NSLocalizedString("Months", comment: "Months"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 20)
            
            Button(action: {
                // Validation
                if creditAmount.isEmpty {
                    showErrorAlert = true
                } else {
                    showSuccessAlert = true
                }
            }) {
                Text(NSLocalizedString("ContinueButton", comment: "Continue button text"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text(NSLocalizedString("Error", comment: "Error alert title")),
                    message: Text(NSLocalizedString("PleaseEnterCreditAmount", comment: "Error message for empty credit amount")),
                    dismissButton: .default(Text(NSLocalizedString("OKButton", comment: "OK button text")))
                )
            }
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text(NSLocalizedString("SuccessCreditTitle", comment: "Success alert title")),
                    message: Text(NSLocalizedString("SuccessCreditMessage", comment: "Success alert message")),
                    dismissButton: .default(Text(NSLocalizedString("OKButton", comment: "OK button text"))) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
        .padding()
        .navigationTitle(NSLocalizedString("CreditApplicationTitle", comment: "Credit application view title"))
        .sheet(isPresented: $showInstallmentsSheet) {
            InstallmentsSelectionView(selectedInstallments: $selectedInstallments)
        }
    }
}

struct InstallmentsSelectionView: View {
    @Binding var selectedInstallments: Int
    
    let installments = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 18, 24, 36]
    
    var body: some View {
        NavigationView {
            List(installments, id: \.self) { installment in
                Button(action: {
                    selectedInstallments = installment
                    dismiss()
                }) {
                    Text("\(installment) " + NSLocalizedString("Months", comment: "Months"))
                        .frame(maxWidth: .infinity, alignment: .leading) // Ortala
                }
            }
            .navigationTitle(NSLocalizedString("SelectInstallments", comment: "Select installments title"))
        }
    }
    
    private func dismiss() {
        // Use presentationMode to dismiss the sheet
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            window.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

struct CreditApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        CreditApplicationView()
    }
}
