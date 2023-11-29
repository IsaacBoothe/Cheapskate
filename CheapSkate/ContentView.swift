//
//  ContentView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/3/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isLoggedIn = false
}

struct ContentView: View {
    @StateObject var appState = AppState()

    var body: some View {
        if appState.isLoggedIn {
            //pass user here somehow????
            MainTabView()
                .environmentObject(appState)
        } else {
            LoginView(appState: appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
