import SwiftUI

struct ExpandableSection: View {
    let title: String
    let details: [String]
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            if isExpanded {
                VStack(alignment: .leading) {
                    ForEach(details, id: \.self) { detail in
                        Text(detail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.vertical, 2)
                    }
                }
                .padding([.leading, .trailing])
                .padding(.bottom,25)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
