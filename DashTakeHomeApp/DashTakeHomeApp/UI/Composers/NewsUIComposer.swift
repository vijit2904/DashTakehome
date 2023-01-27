//
//  NewsUIComposer.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation
import DashTakeHomeLib

final class NewsUIComposer {
    
    private init(){}
    
    static func newsFeedComposedWith(newsLoader: NewsFeedLoader, imageLoader: ImageDataLoader) -> NewsTableViewController {
        let newsVM = NewsArticleViewModel(loader: MainQueueDispatchDecorator(decoratee: newsLoader))
        let refreshController = NewsTableRefeshViewController(viewModel: newsVM)
        let newsController = NewsTableViewController(refreshController: refreshController, viewModel: newsVM)
        newsVM.onNewsFeedLoad = { [weak newsController] news in
            let cellController = news.articles.map{ article in
                NewsArticleCellControlle(viewModel: NewsArticleCellViewModel(model: article,
                                                                             imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)))
            }
            newsController?.tableModel.append(contentsOf: cellController)
        }
        return newsController
    }
}
