//
//  TouristCache.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
public protocol TouristCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ tourist: TouristDTO, for url: URL, completion: @escaping(Result) -> Void)
}

public protocol TouristDetailCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ tourist: TouristInfo, for url: URL, completion: @escaping(Result) -> Void)
}
