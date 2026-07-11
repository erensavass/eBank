import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                    
                    Text(NSLocalizedString("NoCreditMessage", comment: ""))
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Spacer()
                
                NavigationLink(destination: CreditApplicationView()) {
                    Text(NSLocalizedString("ApplyForCreditButton", comment: ""))
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle(NSLocalizedString("CreditsTitle", comment: ""))
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
