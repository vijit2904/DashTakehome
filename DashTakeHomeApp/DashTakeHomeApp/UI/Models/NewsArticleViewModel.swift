//
//  NewsArticleViewModel.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation
import DashTakeHomeLib

final class NewsArticleViewModel {
    
    typealias Observer<T> = (T) -> Void
    
    private let loader: NewsFeedLoader
    
    private var page = 1
    
    init(loader: NewsFeedLoader) {
        self.loader = loader
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onNewsFeedLoad: Observer<NewsFeedItem>?
    
    var reloadNewFetchedRows: Observer<Int>?
    
    func loadNews(){
        onLoadingStateChange?(true)
        loader.load(from: URL(string: EndPoints.news(page: page.description).getUrl())!) { [weak self] result in
            if let newsFeed = try? result.get() {
                self?.onNewsFeedLoad?(newsFeed)
                self?.reloadNewFetchedRows?(newsFeed.articles.count)
            }
            self?.onLoadingStateChange?(false)
        }
    }
    
    func loadNextPage() {
        page += 1
        loadNews()
    }
    
}
