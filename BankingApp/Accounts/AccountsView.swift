import SwiftUI

struct AccountsView: View {
    @State private var accounts: [Account] = loadAccounts()
    @State private var showAddAccountView = false
    @State private var selectedPieIndex = -1
    @State private var selectedAccount: Account?
    
    private var checkingTL: Double {
        accounts.filter { $0.localizedType == NSLocalizedString("Checking TL", comment: "") }
            .map { $0.balance }
            .reduce(0, +)
    }

    private var termTL: Double {
        accounts.filter { $0.localizedType == NSLocalizedString("Term TL Account", comment: "") }
            .map { $0.balance }
            .reduce(0, +)
    }

    private var foreignCurrency: Double {
        accounts.filter { $0.localizedType == NSLocalizedString("Foreign Currency Account", comment: "") }
            .map { $0.balance }
            .reduce(0, +)
    }

    var body: some View {
        NavigationStack {
            VStack {
                if accounts.isEmpty {
                    Text(NSLocalizedString("No accounts added yet.", comment: ""))
                        .padding()
                } else {
                    let totalBalance = checkingTL + termTL + foreignCurrency
                    
                    VStack {
                        Button(action: {
                            selectedPieIndex = -1
                        }) {
                            Text(NSLocalizedString("Total", comment: ""))
                                .foregroundColor(selectedPieIndex == -1 ? .blue : .gray)
                                .font(.headline)
                        }
                        .padding(.bottom, 10)

                        PieChartView(data: [checkingTL, termTL, foreignCurrency], totalBalance: totalBalance, selectedIndex: $selectedPieIndex)
                            .padding()
                    }

                    HStack {
                        Button(action: {
                            selectedPieIndex = 0
                        }) {
                            Text(NSLocalizedString("Checking TL", comment: ""))
                                .foregroundColor(selectedPieIndex == 0 ? .blue : .gray)
                        }
                        .padding()

                        Button(action: {
                            selectedPieIndex = 1
                        }) {
                            Text(NSLocalizedString("Term TL Account", comment: ""))
                                .foregroundColor(selectedPieIndex == 1 ? .blue : .gray)
                        }
                        .padding()

                        Button(action: {
                            selectedPieIndex = 2
                        }) {
                            Text(NSLocalizedString("Foreign Currency Account", comment: ""))
                                .foregroundColor(selectedPieIndex == 2 ? .blue : .gray)
                        }
                        .padding()
                    }

                    List {
                        ForEach(accounts) { account in
                            NavigationLink(destination: AccountDetailView(accounts: $accounts, account: account)) {
                                VStack(alignment: .leading) {
                                    Text(account.localizedType)
                                        .font(.headline)
                                    
                                    HStack {
                                        Text("\(NSLocalizedString("Account No", comment: "")): ")
                                            .font(.subheadline)
                                        Spacer()
                                        Text(account.accountNumber)
                                            .font(.subheadline)
                                    }
                                    
                                    HStack {
                                        Text("\(NSLocalizedString("Balance", comment: "")): ")
                                            .font(.subheadline)
                                        Spacer()
                                        Text("\(String(format: "%.2f", account.balance)) ₺")
                                            .font(.subheadline)
                                    }
                                    
                                    if account.localizedType == NSLocalizedString("Term TL Account", comment: "") {
                                        if let maturity = account.maturityPeriod {
                                            HStack {
                                                Text("\(NSLocalizedString("Maturity Period", comment: "")): ")
                                                    .font(.subheadline)
                                                Spacer()
                                                Text("\(maturity) \(NSLocalizedString("Months", comment: ""))")
                                                    .font(.subheadline)
                                            }
                                        }
                                    }
                                    if account.localizedType == NSLocalizedString("Foreign Currency Account", comment: "") {
                                        if let currencyType = account.currencyType {
                                            HStack {
                                                Text("\(NSLocalizedString("Currency Type", comment: "")): ")
                                                    .font(.subheadline)
                                                Spacer()
                                                Text(currencyType)
                                                    .font(.subheadline)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Button(action: {
                    showAddAccountView.toggle()
                }) {
                    Text(NSLocalizedString("Add New Account", comment: ""))
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .sheet(isPresented: $showAddAccountView) {
                    AddAccountView(accounts: $accounts)
                }
            }
            .navigationTitle(NSLocalizedString("Accounts", comment: ""))
        }
        .onAppear {
            accounts = loadAccounts()
        }
        .onDisappear {
            saveAccounts(accounts)
        }
    }
}
