//
//  HomePageHeader.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI

struct HomePageHeader: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Welcome, User")
                .font(.system(size: 35))
                .bold()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 2)
                .padding(.bottom, 4)
                .foregroundColor(Color(hex: "a49665"))
            
            Text("Finance Tip of the Day")
                .font(.system(size: 22))
                .bold()
            
            Text("display tip here")
                .padding(.top, 5)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 2)
                .foregroundColor(Color(hex: "a49665"))
            

        }
    }
}

struct HomePageHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomePageHeader()
    }
}
