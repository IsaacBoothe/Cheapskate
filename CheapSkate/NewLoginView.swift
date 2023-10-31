//
//  NewLoginView.swift
//  CheapSkate
//
//  Created by Isaac Kim on 10/12/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct NewLoginView: View {
    @State var emailAddress: String = ""
    @State var password: String = ""
    var body: some View {
        Text("New Login Credenntials Page").padding()
        //outline of content
        VStack(content: {
            
            Text("Change user email address")
            TextField("Enter your new email address", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            //text to instruct viewers to enter their password
            Text("Enter your new password")
            SecureField("Enter your new password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(
                action: {
                    newLoginCredential(email: emailAddress, password: password)
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

func newLoginCredential(email: String, password: String){
    let user = Auth.auth().currentUser
    var credential: AuthCredential = EmailAuthProvider.credential(withEmail: "email", password: "pass")

    
    
    
    user?.reauthenticateAndRetrieveData(with: credential, completion: {(authResult, error) in
                if let error = error {
                    // An error happened.
                }else{
                    // User re-authenticated.
                }
            })
}

#Preview {
    NewLoginView()
}