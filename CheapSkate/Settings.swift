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
        VStack {
            Text("Update Account Information")
                .font(.largeTitle)
                .padding()
            
            TextField("New Email", text: $newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Update", action: updateAccount)
                .padding()
            
            Button("Log Out", action: logOut)
                .padding()
            
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
        }
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
