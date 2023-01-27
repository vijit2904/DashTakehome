//
//  TouristDetailsLoaderCacheDecorator.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class TouristDetailsLoaderCacheDecorator: TouristDetailsLoader {
        
    private let decoratee: TouristDetailsLoader
    private let cache: TouristDetailCache
    
    init(decoratee: TouristDetailsLoader, cache: TouristDetailCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func load(from url: URL, completion: @escaping (TouristDetailsLoader.Result) -> Void) {
        return decoratee.load(from: url) { [weak self] result in
            completion(result.map { tourist in
                self?.cache.saveIgnoringTheResult(tourist, for: url)
                return tourist
            })
        }
    }
}

private extension TouristDetailCache {
    func saveIgnoringTheResult(_ tourist: TouristInfo, for url: URL) {
        save(tourist, for: url) { _  in }
    }
}
