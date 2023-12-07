//
//  QuizIntroView.swift
//  CheapSkate
//
//  Created by Isaac Kim on 11/27/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct QuizIntroView: View {
    @State private var quizInfo:Info?
    @State private var questions:[Questions] = []
    @State private var startQuiz: Bool = false
    var body: some View {
        if let info = quizInfo{
            VStack(spacing: 10){
                //the title of the quiz section
                Text(info.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .hAlign(.leading)
                
                // - Custom Label
                CustomLabel("list.dash", "\(questions.count)", "Multiple Choice Questions")
                    .padding(.top, 20)
                
                CustomLabel("person", "\(info.peopleAttended)", "Attended the exercise")
                    .padding(.top, 5)
                
                Divider()
                    .padding(.horizontal, -15)
                    .padding(.top, 15)
                
                //sets the rules view
                if !info.title.isEmpty{
                    RulesView(info.Rules)
                }
                
                // - remove padding
                CustomButton(title: "Start Quiz", onClick: {
                    startQuiz.toggle()
                })
                .vAlign(.leading)
            }
            .padding(15)
            .vAlign(.top)
            
            .fullScreenCover(isPresented: $startQuiz){
                QuestionView(info: info, questions: questions){
                    /// - User has successfully finished the quiz
                    ///  - Thus updating the UI
                    quizInfo?.peopleAttended+=1
                }
            }
            
            
        } else {
            // User sees a progress bar
            VStack(spacing: 4){
                ProgressView()
                Text("Please Wait")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .task{
                do{
                    try await getData()
                } catch{
                    print(error)
                }
            }
        }
    }
    
    //creates the rules view
    @ViewBuilder
    func RulesView(_ rules: [String])-> some View{
        VStack(alignment: .leading, spacing: 15){
            Text("Before you start")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 12)
                .fixedSize(horizontal: false, vertical: true)
            
            ForEach(rules, id: \.self){ rule in
                HStack(alignment: .top, spacing: 10){
                    Circle()
                        .fill(.black)
                        .frame(width:8, height: 8)
                        .offset(y: 6)
                    Text(rule)
                        .font(.callout)
                        .lineLimit(3)
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomLabel(_ image: String,_ title: String,_ subTitle: String)-> some View{
        HStack(spacing: 12){
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45, height:45)
                .background{
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .padding(-1)
                        .background{
                            Circle()
                                .stroke(Color(.black), lineWidth: 1)
                        }
                }
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.black))
                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            .hAlign(.leading)
        }
    }
    
    //fetching quiz data and info
    func getData() async throws{
        let info = try await Firestore.firestore().collection("Quiz").document("sd7BAC1ZPdiTrMp2Tbu7").getDocument().data(as: Info.self)
        do {
            let question = try await Firestore.firestore().collection("Quiz").document("sd7BAC1ZPdiTrMp2Tbu7").collection("Questions").getDocuments()
                .documents
                .compactMap { document -> Questions? in
                    do {
                        return try document.data(as: Questions.self)
                        
                    } catch {
                        print("Error decoding document: \(error.localizedDescription)")
                        return nil
                    }
                }
            
            // Get a random subset of questions (adjust 'numberOfRandomQuestions' as needed)
            let numberOfRandomQuestions = 4
            let randomQuestions = Array(question.shuffled().prefix(numberOfRandomQuestions))
            
            // Use the 'questions' array as needed
            print(questions)
            
            //Changes in the UI the updated information
            await MainActor.run(body: {
                self.quizInfo = info
                self.questions = randomQuestions
            })
        } catch {
            print("Error fetching documents: \(error.localizedDescription)")
        }
    }
}

// Mark: View Extensions
/// useful for moving views between HStack and VStack
extension View{
    func hAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

//Each will have the same safe area ignored button, making it reusable component and reducing code redundancy
struct CustomButton: View{
    var title: String
    var onClick: ()->()
    
    var body: some View{
        //the button the leads the user to the quiz
        Button {
            onClick()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .hAlign(.center)
                .padding(.top, 15)
                .padding(.bottom, 10)
                .foregroundColor(.white)
                .background{
                    Rectangle()
                        .fill(Color(.green))
                        .ignoresSafeArea()
                }
        }
        .padding([.bottom, .horizontal], -15)
    }
}

struct QuizIntroView_Preview: PreviewProvider{
    static var previews: some View{
        QuizView()
    }
}

