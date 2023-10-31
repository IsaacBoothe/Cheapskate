//
//  SignUp.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 10/10/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            Text("Sign Up")
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            Button(
                action: {
                    registerUser(email: email, password: password)
                },
                label: { Text("Sign Up") }
            )
            .foregroundColor(Color.white)
            .padding()
            .background(Color.green)
            .cornerRadius(5)
        }
        .padding()
    }
}

func registerUser(email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
        if error != nil {
            print(error!.localizedDescription)
        }
    }
}
