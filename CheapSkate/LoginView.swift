//
//  LoginView.swift
//  CheapSkate
//
//  Created by Isaac Kim on 10/31/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
        
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(
                    action: {
                        loginUser(email: email, password: password)
                    },
                    label: { Text("Log In") }
                )
                .foregroundColor(Color.white)
                .padding()
                .background(Color.green)
                .cornerRadius(5)
                
                NavigationLink(destination: NewLoginView()) {
                    VStack {
                        Text("Update User Credentials")
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(5)
                }
            
            }
            .padding()
        }
    }
}


func loginUser(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
        if let error = error {
            print("Login error")
        } else {
            print("Login successful")
            // nagivate to future home screen
        }
    }
}

struct Login_Previews: PreviewProvider {
    @State var isLoggedIn: Bool = false

    static var previews: some View {
        LoginView()
    }
}
