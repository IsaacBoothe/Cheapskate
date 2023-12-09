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
}

struct HomePageHeader: View {
    @ObservedObject var tipViewModel = TipViewModel()
    
    func randomTip() -> String {
        guard let randomTip = tipViewModel.tips.first?.tips.randomElement() else {
            return "No tips available"
        }
        return randomTip
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text("Welcome, User")
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
        }
    }
}

struct HomePageHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomePageHeader()
    }
}
