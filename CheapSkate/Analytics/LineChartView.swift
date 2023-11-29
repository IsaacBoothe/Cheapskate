//
//  LineChartView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 11/29/23.
//
import SwiftUI
import Charts
struct LineChartView: View {
        //MARK: will need to query and pass user here and have access to their quiz scores
    let myQuizScores: [WeeklyQuizScores] = [
        WeeklyQuizScores(quiz: "Quiz 1", score: 2),
        WeeklyQuizScores(quiz: "Quiz 2", score: 4),
        WeeklyQuizScores(quiz: "Quiz 3", score: 4),
        WeeklyQuizScores(quiz: "Quiz 4", score: 3),
        WeeklyQuizScores(quiz: "Quiz 5", score: 4)
    ]

    let avgScores: [WeeklyQuizScores] = [
        WeeklyQuizScores(quiz: "Quiz 1", score: 3),
        WeeklyQuizScores(quiz: "Quiz 2", score: 4),
        WeeklyQuizScores(quiz: "Quiz 3", score: 3),
        WeeklyQuizScores(quiz: "Quiz 4", score: 2),
        WeeklyQuizScores(quiz: "Quiz 5", score: 3)
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("My Weekly Quiz Scores")
                .font(.system(size: 25))
                .fontWeight(.bold)
            
            Text("Quiz Scores Out of 4")
                .fontWeight(.thin)
                .font(.system(size: 15))
                .padding(.bottom)
            
            GroupBox(){
                Chart() {
                    ForEach(avgScores) { score in
                        LineMark(
                            x: .value("Quiz", score.quiz),
                            y: .value("Score", score.score),
                            series: .value("", "previous")
                        ).foregroundStyle(Color(hex: "a49665"))
                            .symbol() {
                                Circle()
                                    .fill(Color(hex: "a49665"))
                                    .frame(width: 10, height: 10)
                            }
                        .lineStyle(StrokeStyle(lineWidth: 4, dash: [5, 10]))
                    }
                    
                    ForEach(myQuizScores) { myScore in
                        LineMark(
                            x: .value("Quiz", myScore.quiz),
                            y: .value("Score", myScore.score),
                            series: .value("", "current")
                        ).foregroundStyle(Color(hex: "005035"))
                        .symbol() {
                             Circle()
                                .fill(Color(hex: "005035"))
                                .frame(width: 10, height: 10)
                        }
                        .lineStyle(.init(lineWidth: 4))
                    }
                }
                .chartYScale(domain: 0...5)
                .chartYAxis {
                    AxisMarks(values: .automatic(desiredCount: 4))
                }
                .chartForegroundStyleScale([
                    "My Scores" : Color(hex: "005035"),
                    "Average Scores": Color(hex: "a49665")
                ])
                .chartLegend(position: .top, alignment: .top)
            }.frame(height: 400)
        }.padding()
    }
}

struct WeeklyQuizScores: Identifiable {
        let id = UUID()
        let quiz: String
        let score: Double
    }

