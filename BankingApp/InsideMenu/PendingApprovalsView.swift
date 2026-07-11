import SwiftUI

struct PendingApprovalsView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .padding()
            
            Text(NSLocalizedString("NoPendingApprovalsMessage", comment: "Message indicating no pending approvals"))
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .navigationTitle(NSLocalizedString("PendingApprovalsTitle", comment: "Title for pending approvals screen"))
    }
}

struct PendingApprovalsView_Previews: PreviewProvider {
    static var previews: some View {
        PendingApprovalsView()
    }
}
