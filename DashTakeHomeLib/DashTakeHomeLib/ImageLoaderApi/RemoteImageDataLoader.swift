//
//  RemoteImageDataLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

public final class RemoteImageDataLoader: ImageDataLoader {
    
    private let client: HTTPClient
    
    public init(client: HTTPClient){
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private final class HTTPClientTaskWrapper: ImageDataLoaderTask {
        private var completion: ((ImageDataLoader.Result) -> Void)?

                var wrapped: HTTPClientTask?

                init(_ completion: @escaping (ImageDataLoader.Result) -> Void) {
                    self.completion = completion
                }

                func complete(with result: ImageDataLoader.Result) {
                    completion?(result)
                }

                func cancel() {
                    stopFurtherCompletions()
                    wrapped?.cancel()
                }

                private func stopFurtherCompletions() {
                    completion = nil
                }
    }
    
    public func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        let task = HTTPClientTaskWrapper(completion)
                task.wrapped = client.get(from: url) { [weak self] result in
                    guard self != nil else { return }

                    task.complete(with: result
                        .mapError { _ in Error.connectivity }
                        .flatMap { (data, response) in
                            let isValidResponse = (response.statusCode == 200) && !data.isEmpty
                            return isValidResponse ? .success(data) : .failure(Error.invalidData)
                        })
                }
                return task
    }
    
}
