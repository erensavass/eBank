import Foundation

struct Account: Identifiable, Codable {
    var id = UUID()
    let type: String
    let accountNumber: String
    var balance: Double
    var transactions: [String] = []
    var term: Int?
    var currencyType: String?
    var maturityPeriod: Int? // Yeni ekleme: vade süresi

    static func generateAccountNumber() -> String {
        return String(format: "%08d", Int.random(in: 10000000...99999999))
    }
    

    var localizedType: String {
        switch type {
        case "Checking TL":
            return NSLocalizedString("Checking TL", comment: "")
        case "Foreign Currency Account":
            return NSLocalizedString("Foreign Currency Account", comment: "")
        case "Term TL Account":
            return NSLocalizedString("Term TL Account", comment: "")
        default:
            return type
        }
    }

    var localizedCurrencyType: String {
        switch currencyType {
        case "Euro":
            return NSLocalizedString("Euro", comment: "")
        case "Pound":
            return NSLocalizedString("Pound", comment: "")
        case "Dollar":
            return NSLocalizedString("Dollar", comment: "")
        default:
            return currencyType ?? ""
        }
    }

    var localizedTerm: String {
        guard let term = term else { return "" }
        return String(format: NSLocalizedString("Maturity Period: %d Months", comment: ""), term)
    }
}
