import SwiftUI

struct GiveApprovalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var buttonText: String = "Apply".uppercased()
    @EnvironmentObject var array: ApplicantsArrayObject
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    let applicantID: String
    
    var filteredRequest: [ApplicantsModel] {
        let filtered = array.requestArray.filter { $0.applicantID == applicantID }
        return filtered
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.primary)
                        
                })
                .accentColor(.black)
                .padding(.all, 20)
                .padding(.leading)
                Spacer()
            }
            
            ScrollView(.vertical) {
                Text("Give Approval View")
                    .font(.title)
                    .padding(.bottom, 50)
                
                VStack {
                    if filteredRequest.isEmpty {
                        Text("No requests found for applicantID \(applicantID)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(filteredRequest, id: \.self) { data in
                            VStack(spacing: 20) {
                                if let videoID = extractVideoID(from: data.link) {
                                    YouTubeWebView(videoID: videoID)
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                } else {
                                    Text("Invalid YouTube link")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Button(action: {
                                        rejectApplicant(data)
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Label("REJECT", systemImage: "xmark")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                            .padding()
                                            .frame(height: 50)
                                            .frame(maxWidth: 155)
                                            .background(Color.gray)
                                            .cornerRadius(12)
                                    })
                                    .accentColor(.black)
                                    
                                    Button(action: {
                                        approveApplicant(data)
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Label("APPROVE", systemImage: "checkmark")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                            .padding()
                                            .frame(height: 50)
                                            .frame(maxWidth: 155)
                                            .background(Color.MyTheme.blueColor)
                                            .cornerRadius(12)
                                    })
                                    .accentColor(.black)
                                }
                            }
                            .padding(.all, 50)
                        }
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
        }
    }
    
    func approveApplicant(_ applicant: ApplicantsModel) {
        buttonText = "APPROVE".uppercased()
        AuthService.instance.addCertificateToUser(forUserID: applicant.userID, forCertificateID: applicant.certificateID)
        AuthService.instance.removeRequestFromJury(forUserID: currentUserID ?? "", forApplicantID: applicant.applicantID)
        ApplicantsArrayObject.shared.removeApplicant(userID: applicant.userID, certificateID: applicant.certificateID)
        ApplicantsArrayObject.shared.deleteApplicant(applicantID: applicant.applicantID)
        ApplicantsArrayObject.shared.removeRequest(userID: applicant.userID, applicantID: applicant.applicantID)
        // Other logic to handle the approval...
    }
    
    func rejectApplicant(_ applicant: ApplicantsModel) {
        buttonText = "REJECT".uppercased()
        // Logic to handle rejection, such as removing the applicant from the list or database
        AuthService.instance.removeRequestFromJury(forUserID: currentUserID ?? "", forApplicantID: applicant.applicantID)
        ApplicantsArrayObject.shared.removeRequest(userID: applicant.userID, applicantID: applicant.applicantID)
    }
    
    // Helper function to extract video ID from YouTube link
    func extractVideoID(from link: String) -> String? {
        guard let url = URL(string: link) else { return nil }
        if url.host?.contains("youtube.com") == true {
            let queryItems = URLComponents(string: link)?.queryItems
            let videoID = queryItems?.first(where: { $0.name == "v" })?.value
            return videoID
        } else if url.host?.contains("youtu.be") == true {
            return url.lastPathComponent
        }
        return nil
    }
}

extension URL {
    var queryItems: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return nil }
        var items = [String: String]()
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }
}

#Preview {
    NavigationView {
        GiveApprovalView(applicantID: "exampleUserID")
            .environmentObject(ApplicantsArrayObject.shared)
    }
}
