//
//  LocalDetailTouristLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/27/23.
//

import Foundation

public final class LocalDetailTouristLoader {
    private let store: TouristDetailDataStore
    
    public init(store: TouristDetailDataStore) {
        self.store = store
    }
}


extension LocalDetailTouristLoader: TouristDetailsLoader {
    
    public typealias Result = TouristDetailsLoader.Result
    
    public func load(from url: URL, completion: @escaping (Result) -> Void) {
        store.retrieve(with: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(.some(cache)):
                completion(.success(LocalDetailTouristLoader.toModel(tourist: cache.tourist)))
                
            case .success:
                completion(.success(TouristInfo(id: 0,
                                                name: "",
                                                email: "",
                                                location: "",
                                                memberSince: Date())))
            }
        }
    }
    
    private static func toModel(tourist: LocalTouristInfo) -> TouristInfo {
        return TouristInfo(id: 0,
                           name: tourist.name,
                           email: tourist.email,
                           location: tourist.location,
                           memberSince: tourist.memberSince)
    }
}

extension LocalDetailTouristLoader: TouristDetailCache {
    
    public typealias SaveResult = TouristDetailCache.Result
    
    public func save(_ tourist: TouristInfo, for url: URL, completion: @escaping (SaveResult) -> Void) {
        store.insert(LocalDetailTouristLoader.toLocal(tourist), url: url) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
    
    private static func toLocal(_ detail: TouristInfo) -> LocalTouristInfo {
        return LocalTouristInfo(pages: 0,
                                id: 0,
                                name: detail.name ?? "",
                                email: detail.email ?? "",
                                location: detail.location ?? "",
                                memberSince: detail.memberSince)
    }
}
