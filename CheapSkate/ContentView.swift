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
            MainTabView()
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
