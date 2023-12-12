//
//  HomePageHeader.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI
import Firebase

struct Tip: Identifiable {
    var id: String
    var tips: [String]
}

class TipViewModel: ObservableObject {
    @Published var tips: [Tip] = []
    @Published var userName: String = "User"
    
    private var db = Firestore.firestore()
    
    func fetchTips() {
        db.collection("tips").document("tips").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.data() else {
                print("Error fetching tips: \(error!)")
                return
            }
            
            let tipsData = documents["tips"] as? [String] ?? []
            let tip = Tip(id: "0", tips: tipsData)
            self.tips = [tip]
        }
    }
    
    func fetchUserDocument() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("Error: No user UID available")
            return
        }
        let usersCollectionRef = Firestore.firestore().collection("Users")

        usersCollectionRef.whereField("userID", isEqualTo: currentUserUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }

            if let userDocument = documents.first {
                let userData = userDocument.data()
                self.userName = userData["userName"] as? String ?? ""
//                self.userName = String(self.userName.dropFirst())
//                self.userName = String(self.userName.dropLast())
            } else {
                print("No matching user document found")
            }
        }
    }
    

}

struct HomePageHeader: View {
    @ObservedObject var tipViewModel = TipViewModel()
    
    // Hashes the date and uses the modulus operator to get a unique tip each day
    func randomTip() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: currentDate)
        
        if let tips = tipViewModel.tips.first?.tips, !tips.isEmpty {
            let hashValue = abs(dateString.hashValue) % tips.count
            let randomTip = tips[hashValue]
            return randomTip
        } else {
            return "No tips available"
        }
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text("Welcome, \(tipViewModel.userName)")
                .font(.system(size: 35))
                .bold()
                .padding(.bottom, -3)

            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 2)
                .foregroundColor(Color(hex: "a49665"))
            
            Text("Finance Tip of the Day")
                .font(.system(size: 22))
                .bold()
                .padding(.bottom, -3)
            
            Text(randomTip())
                .font(.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)
                .padding(5)
        
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 2)
                .foregroundColor(Color(hex: "a49665"))
        }
        .onAppear {
            self.tipViewModel.fetchTips()
            self.tipViewModel.fetchUserDocument()
        }
    }
}

struct HomePageHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomePageHeader()
    }
}
