//
//  SignUp.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 10/10/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Cheapskate")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "005035"))
                .underline()
            
            Spacer()
            
            Text("Sign Up")
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
            }.background(Color(hex: "C5C5C5"))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Button(
                action: {
                    registerUser(email: email, password: password)
                },
                label: {
                    VStack {
                        Text("Sign Up").font(.title3)
                    }.frame(width: 120)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color(hex: "005035"))
                    .cornerRadius(5)
                    .bold()
                    .padding()
                    
                }
            )
            
            Spacer()
        }.padding()
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
