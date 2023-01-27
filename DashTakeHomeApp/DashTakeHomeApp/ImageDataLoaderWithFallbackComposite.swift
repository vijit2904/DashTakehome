//
//  ImageDataLoaderWithFallbackComposite.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

class ImageDataLoaderWithFallbackComposite: ImageDataLoader {
    
    private let primary: ImageDataLoader
    private let fallback: ImageDataLoader
    
    init(primary: ImageDataLoader, fallback: ImageDataLoader) {
        self.primary  = primary
        self.fallback = fallback
    }
    
    private class TaskWrapper: ImageDataLoaderTask {
        var warpped: ImageDataLoaderTask?
        
        func cancel() {
            warpped?.cancel()
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> DashTakeHomeLib.ImageDataLoaderTask {
        let task = TaskWrapper()
        task.warpped = primary.loadImageData(from: url) { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                task.warpped = self?.fallback.loadImageData(from: url, completion: completion)
            }
        }
        return task
    }
    
}
