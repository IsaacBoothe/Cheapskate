//
//  AnalyticsView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        VStack {
            TabView {
                MyQuizScores()
                
                LineChartView()
                
                LeaderboardView()
            }.tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}
