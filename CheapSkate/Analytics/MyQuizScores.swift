//
//  MyQuizScores.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 12/12/23.
//

import SwiftUI
import Firebase

struct MyQuizScores: View {
    @State private var scores: [QuizScore] = []
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 10) {
                Text("This Weeks Top Scores")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                
                Text("Quiz 5")
                    .fontWeight(.thin)
                    .font(.system(size: 15))
                    .padding(.bottom, 40)
                
                
                HStack {
                    Text("Order")
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
            }.padding(.top, 100)
                
            ScrollView{
                ForEach(Array(scores.enumerated()), id: \.offset) { (index, score) in
                    HStack {
                        Text("\(index + 1)")
                            .frame(maxWidth: .infinity)

                        Text("\(score.user)")
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
        }.onAppear {
            fetchQuizScores()
        }.padding()
    }
        func fetchQuizScores() {
            let quizScoreCollectionRef = Firestore.firestore().collection("QuizScore")
            
            quizScoreCollectionRef.getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching quiz scores: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No quiz scores found")
                    return
                }
                
                self.scores.removeAll()

                for document in documents {
                    // Access the data dictionary from the document
                    let data = document.data()
                    if let scoreArray = data["Score"] as? [Int], let firstScore = scoreArray.first {
                        self.scores.sort { $0.score > $1.score }
                        print("scored", scores)
                        self.scores.append(QuizScore(user: data["UserName"] as! String, score: firstScore))
                    } else {
                        print("Error: Unable to extract the score from the array")
                    }
                }

            }
        }
    }
    
    struct QuizScore: Identifiable {
        var id: String { user }
        var user: String
        var score: Int
    }

