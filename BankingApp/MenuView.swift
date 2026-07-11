import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: AccountsView()) {
                    Text(NSLocalizedString("Accounts", comment: "Accounts menu item"))
                        .padding(.vertical, 16) // Üst ve alt boşluk
                }
                NavigationLink(destination: CardsView()) {
                    Text(NSLocalizedString("Cards", comment: "Cards menu item"))
                        .padding(.vertical, 16)
                }
                NavigationLink(destination: CreditsView()) {
                    Text(NSLocalizedString("Credits", comment: "Credits menu item"))
                        .padding(.vertical, 16)
                }
                NavigationLink(destination: CampaignsView()) {
                    Text(NSLocalizedString("Campaigns", comment: "Campaigns menu item"))
                        .padding(.vertical, 16)
                }
                NavigationLink(destination: PendingApprovalsView()) {
                    Text(NSLocalizedString("Pending Approvals", comment: "Pending Approvals menu item"))
                        .padding(.vertical, 16)
                }
                
                // Para gönderme ekranı için bağlantı
                NavigationLink(destination: MoneyTransferView()) {
                    Text(NSLocalizedString("SendMoney", comment: "Send Money menu item"))
                        .padding(.vertical, 16)
                }
                
                // Hesap QR Göster için NavigationLink
                NavigationLink(destination: AccountsQRCodeView()) {
                    Text(NSLocalizedString("Show Account QR Code", comment: "Show Account QR Code button"))
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, alignment: .leading) // Tam genişlik
                }
            }
            .navigationTitle(NSLocalizedString("MenuTitle", comment: "Menu title"))
        }
    }
}
