//
//  File.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation

public typealias CachedTourist = (tourist: [LocalTouristInfo], url: URL)

public protocol TouristDataStore {
    
    typealias InsertionResult = Result<Void, Error>
    
    typealias RetrievalResult = Result<CachedTourist?, Error>
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func insert(_ tourist: [LocalTouristInfo], url: URL, completion: @escaping (InsertionResult) -> Void )
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func retrieve(with url: URL, completion: @escaping (RetrievalResult) -> Void)
}

public typealias CachedDetailTourist = (tourist: LocalTouristInfo, url: URL)

public protocol TouristDetailDataStore {
    
    typealias InsertionResult = Result<Void, Error>
    
    typealias RetrievalResult = Result<CachedDetailTourist?, Error>
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func insert(_ tourist: LocalTouristInfo, url: URL, completion: @escaping (InsertionResult) -> Void )
    
    /// The Completion handler can be invoked in any thread.
    /// Client need to dispatch to appropriate threats, if needed.
    func retrieve(with url: URL, completion: @escaping (RetrievalResult) -> Void)
}
