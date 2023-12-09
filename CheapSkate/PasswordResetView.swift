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
                .font(.largeTitle)
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
                
                TextField("Email", text: $email)
                    .padding()
            }.background(Color(hex: "C5C5C5"))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom)
            
            Button(
                action: {
                    resetPassword(email: email)
                },
                label: { Text("Reset Password").font(.title3) }
            ).frame(width: 160)
            .foregroundColor(Color.white)
            .padding()
            .background(Color(hex: "005035"))
            .cornerRadius(5)
            .bold()
            .padding(.top, 15)
            
            if let success = isResetSuccessful {
                Text(success ? "Password reset successfully sent" : "Password reset failed")
                    .foregroundColor(success ? .green : .red)
                    .padding(.top, 10)
            }
            
            Spacer()
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
