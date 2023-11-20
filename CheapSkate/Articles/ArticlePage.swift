//
//  ArticlePage.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 11/9/23.
//

import SwiftUI

struct ArticlePage: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        LikeButton()
    }
}

struct LikeButton: View {
    @State private var isLiked = false
    
    var body: some View {
            Button(action: {
                // Toggle the value of the `isLiked` variable when the button is tapped
                self.isLiked.toggle()
            }) {
                // Use an image or label to indicate that the button is a "like" button
                Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                Text(isLiked ? "Liked" : "Like")
            }
        }
}

struct ArticlePage_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePage()
    }
}
