//
//  CheapSkateApp.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/3/23.
//

import SwiftUI
import Firebase

@main
struct CheapSkateApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase Configured!!")
        
        return true
    }
}
