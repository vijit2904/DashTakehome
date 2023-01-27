//
//  ImageDataLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public protocol ImageDataLoaderTask {
    func cancel()
}

public protocol ImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> ImageDataLoaderTask
}
