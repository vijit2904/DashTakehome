//
//  ImageDataLoaderCacheDecorator.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class ImageDataLoaderCacheDecorator: ImageDataLoader {
        
    private let decoratee: ImageDataLoader
    private let cache: ImageDataCache
    
    init(decoratee: ImageDataLoader, cache: ImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            completion(result.map { data in
                self?.cache.saveIgnoringTheResult(data, for: url)
                return data
            })
        }
    }
}

private extension ImageDataCache {
    func saveIgnoringTheResult(_ data: Data, for url: URL) {
        save(data, for: url) { _ in }
    }
}
