import SwiftUI

struct CreditCardTransactionsView: View {
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: StatementInfoView()) {
                    Text(NSLocalizedString("StatementInfo", comment: ""))
                }
                NavigationLink(destination: DebtInfoView()) {
                    Text(NSLocalizedString("DebtInfo", comment: ""))
                }
                NavigationLink(destination: InstallmentView()) {
                    Text(NSLocalizedString("Installment", comment: ""))
                }
                NavigationLink(destination: LimitUpdateView()) {
                    Text(NSLocalizedString("LimitUpdate", comment: ""))
                }
                NavigationLink(destination: SetPasswordView()) {
                    Text(NSLocalizedString("SetPassword", comment: ""))
                }
                NavigationLink(destination: TransactionPermissionsView()) {
                    Text(NSLocalizedString("TransactionPermissions", comment: ""))
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(NSLocalizedString("CardTransactionsTitle", comment: ""))
    }
}

struct CreditCardTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreditCardTransactionsView()
        }
    }
}
