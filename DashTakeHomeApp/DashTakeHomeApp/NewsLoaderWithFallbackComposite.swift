//
//  NewsLoaderWithFallbackComposite.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

class NewsLoaderWithFallbackComposite: NewsFeedLoader {
    
    private let primary: NewsFeedLoader
    private let fallback: NewsFeedLoader
    
    init(primary: NewsFeedLoader, fallback: NewsFeedLoader) {
        self.primary  = primary
        self.fallback = fallback
    }
    
    
    func load(from url: URL, completion: @escaping (NewsFeedLoader.Result) -> Void) {
        primary.load(from: url) { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.load(from: url, completion: completion)
            }
        }
    }
}
