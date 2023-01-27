//
//  NewsFeedCache.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation

public protocol NewsFeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ news: NewsFeedItem, for url: URL, completion: @escaping(Result) -> Void)
}
