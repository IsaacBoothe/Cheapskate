//
//  HomeView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Settings()) {
                    VStack {
                        Text("Settings")
                    }
                    .cornerRadius(5)
                    .frame(width: 300, height: 2)
                }
                
                // Will need to pass down user's name and finance tip here
                HomePageHeader()
                
                VStack{
                    Text("Featured")
                        .font(.system(size: 30))
                        .bold()
                    
                    // Pass down headline titles to display and attach navigation
                    HeadlinesPreview(
                        header: "Headlines",
                        article1: "article1",
                        article2: "article2"
                    ).padding(.vertical, -20)
                    
                    // Pass down quiz Titles and attach navigation
                    HeadlinesPreview(
                        header: "Top Quizzes",
                        article1: "Quiz title 1",
                        article2: "Quiz title 2"
                    )
                    
                    AnalyticsPreview()
                        .padding(.vertical, -20)
                }.padding(.top, 20)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
