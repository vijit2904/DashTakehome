//
//  ImageDataCache.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation

public protocol ImageDataCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping(Result) -> Void)
}
