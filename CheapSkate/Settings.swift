//
//  Settings.swift
//  CheapSkate
//
//  Created by Isaac Kim on 10/12/23.
//

import SwiftUI
import Firebase

struct Settings: View {
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Account Settings")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "005035"))
                .underline()
            
            Spacer()
            
            HStack {
                Image(systemName: "at")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .padding(.leading)
                
                TextField("New Email", text: $newEmail)
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
                
                SecureField("New Password", text: $newPassword)
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
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
            }
            .background(Color(hex: "C5C5C5"))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Spacer()
            
            Button("Update", action: updateAccount)
                .frame(width: 120)
                .foregroundColor(Color.white)
                .padding()
                .background(Color(hex: "005035"))
                .cornerRadius(5)
                .bold()
                .padding(.top, 15)
            
            Button("Log Out", action: logOut)
                .frame(width: 120)
                .foregroundColor(Color.white)
                .padding()
                .background(Color(hex: "a49665"))
                .cornerRadius(5)
                .bold()
                .padding(.top, 15)
            
            //Print error message if found
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Spacer()
        }.padding()
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func updateAccount() {
        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        if let user = Auth.auth().currentUser {
            if !newEmail.isEmpty {
                user.updateEmail(to: newEmail) { error in
                    if let error = error {
                        errorMessage = "Error updating email: \(error.localizedDescription)"
                    }
                }
            }
            
            if !newPassword.isEmpty {
                user.updatePassword(to: newPassword) { error in
                    if let error = error {
                        errorMessage = "Error updating password: \(error.localizedDescription)"
                    }
                }
            }
            
            errorMessage = "Account updated successfully."
        } else {
            errorMessage = "User not authenticated."
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
