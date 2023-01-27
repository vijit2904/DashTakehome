//
//  NewsLoaderCacheDecorator.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class NewsLoaderCacheDecorator: NewsFeedLoader {
        
    private let decoratee: NewsFeedLoader
    private let cache: NewsFeedCache
    
    init(decoratee: NewsFeedLoader, cache: NewsFeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func load(from url: URL, completion: @escaping (NewsFeedLoader.Result) -> Void) {
        return decoratee.load(from: url) { [weak self] result in
            completion(result.map { news in
                self?.cache.saveIgnoringTheResult(news, for: url)
                return news
            })
        }
    }
}

private extension NewsFeedCache {
    func saveIgnoringTheResult(_ news: NewsFeedItem, for url: URL) {
        save(news, for: url) { _ in }
    }
}
