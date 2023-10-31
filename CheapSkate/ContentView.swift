//
//  ContentView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/3/23.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = false

    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
