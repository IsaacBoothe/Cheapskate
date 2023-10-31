//
//  SignUp.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 10/10/23.
//

import SwiftUI

struct SignUpView: View {
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            Text("Sign Up")
            
            TextField("Username", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            NavigationLink(destination: LoginView()) {
                VStack {
                    Text("Sign Up")
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
