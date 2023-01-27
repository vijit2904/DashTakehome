//
//  NewFeedItem.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public struct NewsFeedItem: Equatable {
    public let pages: Int
    public let articles: [Articles]
    
    public init(pages: Int, articles: [Articles]) {
        self.pages = pages
        self.articles = articles
    }
}
