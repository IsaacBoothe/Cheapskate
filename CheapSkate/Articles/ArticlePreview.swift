//
//  ArticlePreview.swift
//  CheapSkate
//
//  Created by Brennan McLaughlin on 11/9/23.
//

import SwiftUI

struct ArticlePreview: View {
    let header: String
    let preview: String
    @State private var showArticlePage = false
    var body: some View {
        NavigationStack {
            VStack {
                
                Button(action: {showArticlePage = true}) {
                label: do {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex: "ededed"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding()
                            .frame(height: 160)
                        HStack{
                            VStack {
                                Text(header)
                                    .underline(true)
                                    .padding(.vertical, 8)
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                
                                Text(preview)
                                    .padding(.bottom, 2)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                
                            }
                            
                            Spacer()
                            
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color(hex: "005035"))
                        }.frame(width: 340, alignment: .leading)
                    }
                    NavigationLink("", destination: ArticlePage(), isActive: $showArticlePage)
                }
                }
            }
        }
    }
    
    
    struct ArticlePreview_Previews: PreviewProvider {
        static var previews: some View {
            ArticlePreview(header: "Headlines", preview: "preview body text")
        }
    }
}
