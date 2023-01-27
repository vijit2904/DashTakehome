//
//  RemoterTouristInfoLoader.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public final class RemoteTouristInfoLoader {
    
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
}
 extension RemoteTouristInfoLoader: TouristInfoLoader {
    public func load(from url: URL, completion: @escaping (TouristInfoLoader.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(RemoteTouristInfoLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
            
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> TouristInfoLoader.Result {
        Result{
            let touristInfo = try TouristInfoLoaderMapper.map(data, response)
            return TouristDTO(pages: touristInfo.total_pages,
                              info: touristInfo.data.toTouristInfo())
        }
    }
}

private extension Array where Element == TouristData {
    func toTouristInfo() -> [TouristInfo] {
        return map {
            TouristInfo(id: $0.id,
                        name: $0.tourist_name ?? "",
                        email: $0.tourist_email ?? "",
                        location: $0.tourist_location ?? "",
                        memberSince: $0.createdat)
        }
    }
    
}

extension RemoteTouristInfoLoader: TouristDetailsLoader {
    public func load(from url: URL, completion: @escaping (TouristDetailsLoader.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(RemoteTouristInfoLoader.detailMap(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func detailMap(_ data: Data, from response: HTTPURLResponse) -> TouristDetailsLoader.Result {
        Result{
            let detail = try TouristDetailLoaderMapper.map(data, response)
            return  TouristInfo(id: detail.id,
                                name: detail.tourist_name ?? "",
                                email: detail.tourist_email ?? "",
                                location: detail.tourist_location ?? "",
                                memberSince: detail.createdat)
            }
        }
    }
