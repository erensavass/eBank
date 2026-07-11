import Foundation

func loadAccounts() -> [Account] {
    if let data = UserDefaults.standard.data(forKey: "accounts") {
        do {
            let savedAccounts = try JSONDecoder().decode([Account].self, from: data)
            return savedAccounts
        } catch {
            print("Hata: Hesaplar yüklenemedi: \(error)")
        }
    }
    return []
}

func saveAccounts(_ accounts: [Account]) {
    do {
        let encoded = try JSONEncoder().encode(accounts)
        UserDefaults.standard.set(encoded, forKey: "accounts")
    } catch {
        print("Hata: Hesaplar kaydedilemedi: \(error)")
    }
}
