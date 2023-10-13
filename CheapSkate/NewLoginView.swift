//
//  NewLoginView.swift
//  CheapSkate
//
//  Created by Isaac Kim on 10/12/23.
//

import SwiftUI

struct NewLoginView: View {
    @State var userName: String = ""
    @State var emailAddress: String = ""
    @State var password: String = ""
    var body: some View {
        Text("New Login Credenntials Page").padding()
        //outline of content
        VStack(content: {
            Text("Placeholder")
            TextField("Enter your username", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Change user email address")
            TextField("Enter your new email address", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Enter your new password")
            SecureField("Enter your new password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(
                action: {
                // did tap
                },
                label: { 
                    Text("Update") }
                )
                .padding()
                .background(Color.white)
                .cornerRadius(5)
            
        })
        .padding()
        .background(Color.green)
    }
}

#Preview {
    NewLoginView()
}
