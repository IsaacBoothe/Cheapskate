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
                LeaderboardView()
                
                LineChartView()
            }.tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}
