//
//  PasswordResetView.swift
//  CheapSkate
//
//  Created by Jared Fulk on 10/30/23.
//

import SwiftUI
import FirebaseAuth

struct PasswordResetView: View {
    @State var email: String = ""
    @State var isResetSuccessful: Bool? = nil
    var body: some View {
            VStack {
                Text("Password Reset")
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
    Button(
        action: {
            resetPassword(email: email)
        },
        label: { Text("Reset Password") }
    )
    .foregroundColor(Color.white)
    .padding()
    .background(Color.green)
    .cornerRadius(5)
    
    if let success = isResetSuccessful {
        Text(success ? "Password reset successfully sent" : "Password reset failed")
            .foregroundColor(success ? .green : .red)
            .padding(.top, 10)
        }
    }
    .padding()
}

func resetPassword(email: String) {
    Auth.auth().sendPasswordReset(withEmail: email) { (error) in
        if let error = error {
            print("Password reset error: \(error.localizedDescription)")
            self.isResetSuccessful = false
        } else {
            print("Password reset email sent")
            self.isResetSuccessful = true
        }
    }
}
}
