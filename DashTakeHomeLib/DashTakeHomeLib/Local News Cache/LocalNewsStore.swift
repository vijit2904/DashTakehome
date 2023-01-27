//
//  LocalNewsStore.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public typealias CachedNews = (news: [LocalNewsFeed], url: URL)

public protocol NewsFeedStore {
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<CachedNews?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func insert(_ news: [LocalNewsFeed], url: URL, completion: @escaping InsertionCompletion)
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func retrieve(with url: URL, completion: @escaping RetrievalCompletion)
}
