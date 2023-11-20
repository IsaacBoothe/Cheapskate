//
//  ArticlePage.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 11/9/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import Firebase

struct ArticlePage: View {
    let controller = ArticleModelController(article: "Article1")
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        LikeButton(viewModel: controller)
    }
}

struct LikeButton: View {
    let articleService = ArticleService()
    @ObservedObject var viewModel: ArticleModelController
    
    init(viewModel: ArticleModelController) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button{
            if viewModel.liked ?? false {
                viewModel.unlikeArticle()
            } else {
                viewModel.likeArticle()
            }
            
        } label: {
                Image(systemName: viewModel.liked ?? false ? "hand.thumbsup.fill" : "hand.thumbsup")
            }
        }
}

struct ArticlePage_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePage()
    }
}
