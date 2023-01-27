//
//  File.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

final class TouristInfoLoaderMapper {
    private init(){}
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> TouristApiModel {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard response.statusCode == 200, let touristInfo = try? decoder.decode(TouristApiModel.self, from: data)
        else { throw RemoteTouristInfoLoader.Error.invalidData }
        return touristInfo
    }
}

final class TouristDetailLoaderMapper {
    private init(){}
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> TouristData {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard response.statusCode == 200, let touristInfo = try? decoder.decode(TouristData.self, from: data)
        else { throw RemoteTouristInfoLoader.Error.invalidData }
        return touristInfo
    }
}
