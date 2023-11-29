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
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: Settings()) {
                        VStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                        }.padding(20)
                        .frame(height: 10)
                        .padding(.top, 5)
                    }
                }
                // Will need to pass down user's name and finance tip here
                HomePageHeader()
                
                VStack{
                    Text("Featured")
                        .font(.system(size: 30))
                        .bold()
                        .padding(.top, -20)
                    
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
