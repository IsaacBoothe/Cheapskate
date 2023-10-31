//
//  Login.swift
//  CheapSkate
//
//  Created by Walker Clem on 10/30/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var appState: AppState
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
                
                NavigationLink(destination: PasswordResetView()) {
                    VStack {
                        Text("Forgot Password?")
                    }
                    .foregroundColor(Color.white)
                    .font(.system(size: 12))
                    .padding()
                    .background(Color.green)
                    .cornerRadius(5)
                }
                
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
                
               NavigationLink(destination: SignUpView()) {

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
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Login error")
            } else {
                print("Login successful")
                appState.isLoggedIn = true
            }
        }
    }
}




struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(appState: AppState())
    }
}
