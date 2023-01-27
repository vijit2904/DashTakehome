//
//  TouristLoaderCacheDecorator.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class TouristLoaderCacheDecorator: TouristInfoLoader {
        
    private let decoratee: TouristInfoLoader
    private let cache: TouristCache
    
    init(decoratee: TouristInfoLoader, cache: TouristCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func load(from url: URL, completion: @escaping (TouristInfoLoader.Result) -> Void) {
        return decoratee.load(from: url) { [weak self] result in
            completion(result.map { tourist in
                self?.cache.saveIgnoringTheResult(tourist, for: url)
                return tourist
            })
        }
    }
}

private extension TouristCache {
    func saveIgnoringTheResult(_ tourist: TouristDTO, for url: URL) {
        save(tourist, for: url) { _  in }
    }
}
