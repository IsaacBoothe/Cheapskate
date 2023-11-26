//
//  MainTabView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ArticlesView(viewModel: ArticleModelController(article: "Article1"))
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Articles")
                }
            
            QuizView()
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("Quizzes")
                }
            
           AnalyticsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Analytics")
                }
        }.accentColor(Color(hex: "005035"))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
