//
//  ArticlesView.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI

struct ArticlesView: View {
    var body: some View {
        VStack {
            Text("Monthly Articles")
            
            ArticlePreview(
                header: "Importance of Saving",
                preview: "Lorem Ipsum")
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
