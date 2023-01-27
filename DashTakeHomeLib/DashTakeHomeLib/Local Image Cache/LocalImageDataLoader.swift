//
//  LocalImageDataLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

public final class LocalImageDataLoader {
    private let store: ImageDataStore
    
    public init(store: ImageDataStore) {
        self.store = store
    }
}

extension LocalImageDataLoader: ImageDataCache {
    
    public typealias SaveResults = ImageDataCache.Result
    
    public enum saveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL, completion: @escaping (SaveResults) -> Void) {
        store.insert(data, url: url) { [weak self] result in
            guard self != nil else { return }
            completion(result.mapError {_ in saveError.failed})
            
        }
    }
}

extension LocalImageDataLoader: ImageDataLoader {
    public typealias LoadResult = ImageDataLoader.Result

        public enum LoadError: Error {
            case failed
            case notFound
        }
    
    private final class LoadImageDataTask: ImageDataLoaderTask {
        private var completion: ((ImageDataLoader.Result) -> Void)?


                init(_ completion: @escaping (ImageDataLoader.Result) -> Void) {
                    self.completion = completion
                }

                func complete(with result: ImageDataLoader.Result) {
                    completion?(result)
                }

                func cancel() {
                    stopFurtherCompletions()
                }

                private func stopFurtherCompletions() {
                    completion = nil
                }
    }
    
    
    public func loadImageData(from url: URL, completion: @escaping (LoadResult) -> Void) -> ImageDataLoaderTask {
        let task = LoadImageDataTask(completion)
        store.retrieve(dataForUrl: url) { [weak self] result in
            guard self != nil else { return }
            
            task.complete(with: result
                .mapError { _ in LoadError.failed }
                .flatMap { data in
                    data.map { .success($0) } ?? .failure(LoadError.notFound)
                })
        }
        return task
    }
}
