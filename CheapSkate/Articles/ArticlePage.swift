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
        ScrollView {
            Text("Saving money is a fundamental aspect of financial well-being and stability. It serves as a crucial foundation for achieving both short-term and long-term financial goals. The importance of saving extends beyond simply accumulating wealth; it provides a safety net during unexpected expenses and ensures a more secure future. \n               Emergency situations can arise unexpectedly, ranging from medical expenses to car repairs. Having savings allows individuals to navigate these challenges without resorting to high-interest loans or accumulating debt. This financial cushion serves as a form of self-insurance, offering peace of mind and resilience in the face of unforeseen circumstances. \n             Furthermore, saving enables individuals to pursue their long-term aspirations. Whether it's buying a home, starting a business, or funding education, having a savings reserve provides the necessary capital to turn these dreams into reality. Without savings, individuals may find themselves limited in their ability to seize opportunities and achieve their desired lifestyle. \n Moreover, saving fosters financial discipline and responsibility. It encourages individuals to budget wisely, distinguish between needs and wants, and make informed financial decisions. This discipline not only contributes to personal financial stability but also promotes a sense of control over one's financial destiny. \n             In the broader economic context, a population with a culture of saving contributes to economic growth and stability. Savings deposited in financial institutions are often channeled into investments, supporting economic development and job creation. Therefore, individual saving habits play a vital role in shaping the overall economic landscape. \n             In conclusion, saving is not merely a financial habit; it is a cornerstone of personal and economic resilience. It empowers individuals to navigate life's uncertainties, pursue their dreams, and contribute to the overall well-being of society. Developing a habit of saving is an investment in a more secure and prosperous future.")
                .fixedSize(horizontal: false, vertical: true)
            
            LikeButton(viewModel: controller)
        }
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
