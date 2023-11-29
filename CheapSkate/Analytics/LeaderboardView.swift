//
//  LeaderboardView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 11/29/23.
//

import SwiftUI

struct LeaderboardView: View {
    let currentWeekScores: [TopWeeklyScores] = [
        TopWeeklyScores(username: "BMclaughlin", rank: 1, score: 100),
        TopWeeklyScores(username: "IKim", rank: 2, score: 100),
        TopWeeklyScores(username: "WClem", rank: 3, score: 75),
        TopWeeklyScores(username: "JFulk", rank: 4, score: 50),
        TopWeeklyScores(username: "IBoothe", rank: 5, score: 25),
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("This Weeks Top Scores")
                .font(.system(size: 25))
                .fontWeight(.bold)
            
            Text("Quiz 5")
                .fontWeight(.thin)
                .font(.system(size: 15))
                .padding(.bottom, 40)
            
            
            HStack {
                Text("Rank")
                    .bold()
                    .frame(maxWidth: .infinity)

                Text("User")
                    .bold()
                    .frame(maxWidth: .infinity)

                Text("Score")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.gray.opacity(0.3))

            ForEach(currentWeekScores) { score in
                HStack {
                    Text("\(score.rank)")
                        .frame(maxWidth: .infinity)

                    Text("\(score.username)")
                        .frame(maxWidth: .infinity)

                    Text("\(score.score)")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
        }
        .padding()
    }
}

struct TopWeeklyScores: Identifiable {
    let id = UUID()
    let username: String
    let rank: Int
    let score: Int
}
