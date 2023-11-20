//
//  ArticleService.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 11/19/23.
//

import Foundation
import Firebase

class ArticleService {
    func likeArticle(_ article: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let likesRef = Firestore.firestore().collection("Articles").document(article).collection("likes")
        
        likesRef.document(uid).setData([:]) { _ in
            completion(true)
        }
    }
    
    func checkIfLiked(_ article: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("Articles").document(article).collection("likes").document(uid).getDocument {
            snapshot, _ in
            guard let snapshot = snapshot else { return }
            completion(snapshot.exists)
        }
    }
    
    func unlikeArticle(_ article: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let likesRef = Firestore.firestore().collection("Articles").document(article).collection("likes")
        likesRef.document(uid).delete { _ in
            completion(true)
        }
    }
}
