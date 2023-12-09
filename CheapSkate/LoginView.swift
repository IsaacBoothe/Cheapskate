//
//  LoginView.swift
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
                //maybe push this down a little bit // add very light grey background
                Text("Cheapskate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "005035"))
                    .underline()
                
                Spacer()
                
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "a49665"))

                HStack {
                    Image(systemName: "at")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .padding(.leading)
                    
                    TextField("Email", text: $email)
                        .padding()
                }
                .background(Color(hex: "C5C5C5"))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .padding(.leading)
                    
                    SecureField("Password", text: $password)
                        .padding()
                }
                .background(Color(hex: "C5C5C5"))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                Button(
                    action: {
                        loginUser(email: email, password: password)
                    },
                    label: { Text("Log In").font(.title3) }
                )
                .frame(width: 120)
                .foregroundColor(Color.white)
                .padding()
                .background(Color(hex: "005035"))
                .cornerRadius(5)
                .bold()
                .padding(.top, 15)
                
                
               NavigationLink(destination: SignUpView()) {
                    VStack {
                        Text("Sign Up").font(.title3)
                    }
                    .frame(width: 120)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color(hex: "005035"))
                    .cornerRadius(5)
                    .bold()
                    .padding()
                }
                
                NavigationLink(destination: PasswordResetView()) {
                    VStack {
                        Text("Forgot Password?")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(Color.white)
                    .padding(6)
                    .background(Color(hex: "a49665"))
                    .cornerRadius(5)
                    .padding(.top, 30)
                }
                
                 Spacer()
            }
            .padding()
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
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
