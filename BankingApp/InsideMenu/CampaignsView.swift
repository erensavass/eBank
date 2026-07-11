import SwiftUI

struct Campaign: Identifiable {
    let id = UUID()
    let image: String
    let titleKey: String
    let expiryDateKey: String
    let descriptionKey: String
    let detailsKey: String
    
    var title: String {
        NSLocalizedString(titleKey, comment: "")
    }
    var expiryDate: String {
        NSLocalizedString(expiryDateKey, comment: "")
    }
    var description: String {
        NSLocalizedString(descriptionKey, comment: "")
    }
    var details: String {
        NSLocalizedString(detailsKey, comment: "")
    }
}

struct CampaignsView: View {
    @State private var participatedCampaigns: [UUID] = []
    
    let campaigns = [
        Campaign(image: "IMG_3657", titleKey: "title1", expiryDateKey: "expiryDate1", descriptionKey: "description1", detailsKey: "details1"),
        Campaign(image: "IMG_3658", titleKey: "title2", expiryDateKey: "expiryDate2", descriptionKey: "description2", detailsKey: "details2"),
        Campaign(image: "IMG_3655", titleKey: "title3", expiryDateKey: "expiryDate3", descriptionKey: "description3", detailsKey: "details3"),
        Campaign(image: "IMG_3656", titleKey: "title4", expiryDateKey: "expiryDate4", descriptionKey: "description4", detailsKey: "details4")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(campaigns) { campaign in
                        VStack {
                            Image(campaign.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                            
                            Text(campaign.expiryDate)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top, 5)
                            
                            Text(campaign.title)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            HStack {
                                if participatedCampaigns.contains(campaign.id) {
                                    Label(NSLocalizedString("participated", comment: ""), systemImage: "checkmark")
                                        .foregroundColor(.blue)
                                        .padding()
                                } else {
                                    Button(action: {
                                        participate(in: campaign)
                                    }) {
                                        Text(NSLocalizedString("participate", comment: ""))
                                            .foregroundColor(.blue)
                                            .padding()
                                    }
                                }
                                
                                Spacer()
                                
                                NavigationLink(destination: CampaignDetailView(campaign: campaign, participatedCampaigns: $participatedCampaigns)) {
                                    Text(NSLocalizedString("campaignDetails", comment: ""))
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    private func participate(in campaign: Campaign) {
        if !participatedCampaigns.contains(campaign.id) {
            participatedCampaigns.append(campaign.id)
        }
    }
}

struct CampaignDetailView: View {
    let campaign: Campaign
    @Binding var participatedCampaigns: [UUID]
    @State private var isExpanded = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(campaign.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(campaign.expiryDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                Text(campaign.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text(campaign.description)
                    .padding(.horizontal)
                
                DisclosureGroup(NSLocalizedString("campaignDetails", comment: ""), isExpanded: $isExpanded) {
                    Text(campaign.details)
                        .padding(.horizontal)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                if participatedCampaigns.contains(campaign.id) {
                    Label(NSLocalizedString("participated", comment: ""), systemImage: "checkmark")
                        .foregroundColor(.blue)
                        .padding()
                } else {
                    Button(action: {
                        participateInCampaign()
                    }) {
                        Text(NSLocalizedString("participate", comment: ""))
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
            }
            .navigationTitle(NSLocalizedString("Campaigns", comment: ""))
        }
    }
    
    private func participateInCampaign() {
        if !participatedCampaigns.contains(campaign.id) {
            participatedCampaigns.append(campaign.id)
        }
    }
}

#Preview {
    CampaignsView()
}
