//
//  ArticleModelController.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 11/19/23.
//

import Foundation

class ArticleModelController: ObservableObject {
    var article: String
    @Published var liked: Bool? = false
    private let service = ArticleService()
    
    init(article: String) {
        self.article = article
        checkIfUserLiked()
    }
    
    func likeArticle() {
        service.likeArticle(article) {_ in self.liked = true}
    }
    
    func unlikeArticle() {
        service.unlikeArticle(article) {_ in self.liked = false}
    }
    
    func checkIfUserLiked() {
        service.checkIfLiked(article) {liked in
            if liked {
                self.liked = true
            }
        }
    }
}
