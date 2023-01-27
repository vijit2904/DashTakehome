//
//  MainQueueDispatchDecorator.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation
import DashTakeHomeLib

final class MainQueueDispatchDecorator<T>{
    
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: NewsFeedLoader where T == NewsFeedLoader {
    
    func load(from url: URL, completion: @escaping (NewsFeedLoader.Result) -> Void) {
        decoratee.load(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: ImageDataLoader where T == ImageDataLoader {
    
    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        decoratee.loadImageData(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: TouristInfoLoader where T == TouristInfoLoader {
    func load(from url: URL, completion: @escaping (TouristInfoLoader.Result) -> Void) {
        decoratee.load(from: url) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: TouristDetailsLoader where T == TouristDetailsLoader {
    func load(from url: URL, completion: @escaping (TouristDetailsLoader.Result) -> Void) {
        decoratee.load(from: url) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
    
    
}
