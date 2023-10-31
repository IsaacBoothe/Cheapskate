//
//  HomeHeadlines.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI

struct HeadlinesPreview: View {
    let header: String
    let article1: String
    let article2: String
    var body: some View {
        VStack {

            Button {
                //might need to have a completion handler thats called here,
                //and then in homeview I would attach the path
                print("button clicked!!!")
            } label: {
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

                            Text("Article 1")
                                .padding(.bottom, 2)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            
                            Text("Article 2")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.forward.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(hex: "005035"))
                    }.frame(width: 340, alignment: .leading)
                }
            }

        }
    }
}

struct HomeHeadlines_Previews: PreviewProvider {
    static var previews: some View {
        HeadlinesPreview(header: "Headlines", article1: "Article1", article2: "Article 2")
    }
}

