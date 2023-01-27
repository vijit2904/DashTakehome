//
//  RemoteNewsFeedLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public final class RemoteNewsFeedLoader: NewsFeedLoader {
    
   private let client: HTTPClient
    
   public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public func load(from url: URL, completion: @escaping (NewsFeedLoader.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(RemoteNewsFeedLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
            
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> NewsFeedLoader.Result {
        Result{
            let newsFeed = try NewsFeedLoaderMapper.map(data, response)
            return NewsFeedItem(pages: newsFeed.total_pages,
                                articles: newsFeed.data.toNewsArticles())
        }
    }
    
}

private extension Array where Element == NewsData {
    func toNewsArticles() -> [Articles] {
        return map {
            Articles(title: $0.title,
                     description: $0.description,
                     location: $0.location,
                     multiMedia: $0.multiMedia.toMultiMedia(),
                     date: $0.createdat,
                     user: User(userName: $0.user.name,
                                profileImgUrl: $0.user.profilepicture),
                     noOfComments: $0.commentCount)
        }
    }
}

private extension Array where Element == NewsMultiMedia {
    func toMultiMedia() -> [MultiMedia] {
        return map{
            MultiMedia(title: $0.title,
                       description: $0.description,
                       imageUrl: $0.url,
                       date: $0.createat)
        }
    }
}
