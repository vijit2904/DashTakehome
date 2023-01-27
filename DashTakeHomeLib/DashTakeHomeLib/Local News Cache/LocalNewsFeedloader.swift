//
//  LocalNewsFeedloader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

public final class LocalNewsFeedloader {
    private let store: NewsFeedStore
    
   public init(store: NewsFeedStore) {
        self.store = store
    }
}

extension LocalNewsFeedloader: NewsFeedLoader {
    
    public typealias LoadResult = NewsFeedLoader.Result
    
    public func load(from url: URL, completion: @escaping (LoadResult) -> Void) {
        store.retrieve(with: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(.some(cache)):
                completion(.success(cache.news.toModels()))
                
            case .success:
                completion(.success(NewsFeedItem(pages: 0, articles: [])))
            }
        }
    }
}

private extension Array where Element == LocalNewsFeed {
    func toModels() -> NewsFeedItem {
        let articles = map {
            Articles(title: $0.title,
                     description: $0.description,
                     location: $0.location,
                     multiMedia: $0.multiMedia.map { mm in
                MultiMedia(title: mm.title,
                           description: mm.description,
                           imageUrl: mm.imageUrl,
                           date: mm.date)
            },
                     date: $0.date,
                     user: User(userName: $0.user.userName,
                                profileImgUrl: $0.user.profileImgUrl),
                     noOfComments: $0.noOfComments)
        }
        
        return NewsFeedItem(pages: first?.pages ?? 0,
                            articles: articles)
    }
}

extension LocalNewsFeedloader: NewsFeedCache {
    
    public typealias SaveResult = NewsFeedCache.Result
    
    public func save(_ news: NewsFeedItem, for url: URL, completion: @escaping(NewsFeedCache.Result) -> Void) {
        store.insert(news.articles.toLocal(pages: news.pages), url: url) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == Articles {
    func toLocal(pages: Int) -> [LocalNewsFeed] {
        return map {
            LocalNewsFeed(pages: pages,
                          title: $0.title,
                          description: $0.description,
                          location: $0.location,
                          multiMedia: $0.multiMedia.map { mm in
                LocalMultiMedia(title: mm.title,
                                description: mm.description,
                                imageUrl: mm.imageUrl,
                                date: mm.date)
            },
                          date: $0.date,
                          user: LocalUser(userName: $0.user.userName,
                                          profileImgUrl: $0.user.profileImgUrl),
                          noOfComments: $0.noOfComments)
        }
    }
}
