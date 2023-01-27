//
//  FeedLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public protocol NewsFeedLoader {
    typealias Result = Swift.Result<NewsFeedItem, Error>
    func load(from url: URL, completion: @escaping (Result) -> Void)
}
