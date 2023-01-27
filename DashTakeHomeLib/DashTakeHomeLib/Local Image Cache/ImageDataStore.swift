//
//  ImageDataStore.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

public protocol ImageDataStore {
    
    typealias InsertionResult = Result<Void, Error>
    
    typealias RetrievalResult = Result<Data?, Error>
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func insert(_ data: Data, url: URL, completion: @escaping (InsertionResult) -> Void)
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func retrieve(dataForUrl: URL, completion: @escaping (RetrievalResult) -> Void)
}
