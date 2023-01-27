//
//  LocalTouristLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation

public final class LocalTouristLoader {
    private let store: TouristDataStore
    
    public init(store: TouristDataStore) {
        self.store = store
    }
}

extension LocalTouristLoader: TouristInfoLoader {
    
    public typealias LoadResult = TouristInfoLoader.Result
    
    public func load(from url: URL, completion: @escaping (LoadResult) -> Void) {
        store.retrieve(with: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(.some(cache)):
                completion(.success(cache.tourist.toModels()))
                
            case .success:
                completion(.success(TouristDTO(pages: 0, info: [])))
            }
        }
    }
}


private extension Array where Element == LocalTouristInfo {
    
    func toModels() -> TouristDTO {
        return TouristDTO(pages: first?.pages ?? 0,
                          info: toInfoModel())
    }
    
    func toInfoModel() -> [TouristInfo] {
        return map {
            TouristInfo(id: $0.id,
                        name: $0.name,
                        email: $0.email,
                        location: $0.location,
                        memberSince: $0.memberSince)
        }
    }
    
}

extension LocalTouristLoader: TouristCache {
    
    public typealias SaveResult = TouristCache.Result
    
    public func save(_ tourist: TouristDTO, for url: URL, completion: @escaping (SaveResult) -> Void) {
        store.insert(tourist.info.toLocal(pages: tourist.pages), url: url) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}


private extension Array where Element == TouristInfo {
    
    func toLocal(pages: Int) -> [LocalTouristInfo] {
        return map {
            LocalTouristInfo(pages: pages,
                             id: $0.id,
                             name: $0.name ?? "",
                             email: $0.email ?? "",
                             location: $0.location ?? "",
                             memberSince: $0.memberSince)
        }
    }
}
