//
//  TouristInfoLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public protocol TouristInfoLoader {
    typealias Result = Swift.Result<TouristDTO, Error>
    func load(from url: URL, completion: @escaping (Result) -> Void)
}

public protocol TouristDetailsLoader {
    typealias Result = Swift.Result<TouristInfo, Error>
    func load(from url: URL, completion: @escaping (Result) -> Void)
}
