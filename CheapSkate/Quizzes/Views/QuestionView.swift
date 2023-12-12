//
//  QuestionView.swift
//  CheapSkate
//
//  Created by Isaac Kim on 11/27/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct QuestionView: View {
    var info: Info
    @State var questions: [Questions]
    var onFinish: ()->()
    // - View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var score: CGFloat = 0
    @State private var showScoreCard: Bool = false
    var body: some View {
        VStack(spacing:15){
            Button{
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .hAlign(.leading)
            //Title of the quiz the user is taking
            Text(info.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "a49665"))
                .hAlign(.leading)
            //Progress bar that shows how much the user needs to complete the quiz
            GeometryReader{
                let size = $0.size
                ZStack(alignment: .leading){
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    Rectangle()
                        .fill(Color(.systemGreen))
                        .frame(width: progress * size.width, alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(height: 15)
            .padding(.top, 5)
            
            //Questions formatting and seting them up
            GeometryReader{_ in
                
                ForEach(questions.indices, id: \.self) {index in
                    if currentIndex == index{
                        QuestionView(questions[currentIndex])
                            //The view enters from the left and exits to the right
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
            }
            .padding(.vertical, 15)
            
            //Change the button to Finish the Quiz once they arrive to the last question
            CustomButton(title: currentIndex == (questions.count - 1) ? "Finish" : "Next Question", onClick: {
                if currentIndex == (questions.count - 1){
                    //Presents the score card view
                    showScoreCard.toggle()
                } else {
                    withAnimation(.easeInOut){
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(questions.count - 1)
                    }
                }
            })
            .disabled(questions[currentIndex].tappedAnswer == "")
        }
        .padding(15)
        .hAlign(.center).vAlign(.top)
        .background{
            Color(.black)
                .ignoresSafeArea()
        }
        
        //This View is going to be a bit dark due to choosing a dark background
        .environment(\.colorScheme, .dark)
        .fullScreenCover(isPresented: $showScoreCard){
            // - Display the score out of 100%
            ScoreCardView(score: score / CGFloat(questions.count) * 100){
                /// - Closing view
                dismiss()
                onFinish()
            }
        }
    }
    @ViewBuilder
    func QuestionView(_ question: Questions) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Question \(currentIndex + 1)/\(questions.count)")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.leading)

                Text(question.question)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .lineLimit(nil) // Allow text to wrap
                    .padding(.leading)

                VStack(spacing: 12) {
                    ForEach(question.choice, id: \.self) { choice in
                        // - Displaying Correct and Wrong answers after users have Tapped any one of the Options
                        ZStack {
                            ChoiceView(choice, .gray)
                                .opacity(question.answer == choice && question.tappedAnswer != "" ? 0 : 1)
                            ChoiceView(choice, .green)
                                .opacity(question.answer == choice && question.tappedAnswer != "" ? 1 : 0)
                            ChoiceView(choice, .red)
                                .opacity(question.tappedAnswer == choice && question.tappedAnswer != question.answer ? 1 : 0)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // Disabling Tap if an answer was selected
                            guard questions[currentIndex].tappedAnswer == "" else { return }
                            withAnimation(.easeInOut) {
                                questions[currentIndex].tappedAnswer = choice
                                /// - Whenever the correct answer is chosen the score will be updated
                                if question.answer == choice {
                                    score += 1.0
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                
                Text(question.explanation)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .padding(.leading)
                    .opacity(question.tappedAnswer != "" ? 1 : 0)
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
            }
            .padding(.horizontal, 15)
            .frame(minHeight: 0, maxHeight: .infinity) // Ensure the inner VStack can grow vertically
        }
    }


    
    @ViewBuilder
    func ChoiceView(_ choice: String,_ tint: Color)->some View{
        Text(choice)
            .foregroundColor(tint)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .hAlign(.leading)
            .background{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(tint.opacity(0.15))
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                    }
            }
    }
}

struct QuestionsView_Previews: PreviewProvider{
    static var previews: some View {
        QuizView()
    }
}

struct ScoreCardView: View{
    var score: CGFloat
    // - Move to the quiz page once this view is dismissed
    var onDismiss: ()-> ()
    @Environment(\.dismiss) private var dismiss
    var body: some View{
        VStack{
            VStack(spacing: 15){
                Text("Result of Your Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    Text("Congratulations! You \n have score")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    //Removing the float point
                    Text(String(format: "%.0f", score) + "%")
                        .font(.title.bold())
                        .padding(.bottom, 10)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .hAlign(.center)
                .background{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                }
            }
            .vAlign(.center)
            
            CustomButton(title: "Back to Home"){
                /// Updates the people attended the quiz before it closes
                Firestore.firestore().collection("Quiz").document("sd7BAC1ZPdiTrMp2Tbu7").updateData([
                    "peopleAttended": FieldValue.increment(1.0)
                ])
                /// Add the user scores to the firebase into a collection of users scores
                Firestore.firestore().collection("QuizScore").addDocument(data: ["Score": FieldValue.arrayUnion([score]), "User": Auth.auth().currentUser?.uid]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                onDismiss()
                dismiss()
            }
        }
        .padding(15)
        .background{
            Color(.black)
                .ignoresSafeArea()
        }
    }
}

