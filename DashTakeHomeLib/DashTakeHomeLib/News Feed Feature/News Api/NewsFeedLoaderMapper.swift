//
//  NewsFeedLoaderMapper.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

final class NewsFeedLoaderMapper {
    private init(){}
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> NewsFeedApiModel {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard response.statusCode == 200, let newsFeed = try? decoder.decode(NewsFeedApiModel.self, from: data)
        else { throw RemoteNewsFeedLoader.Error.invalidData }
        return newsFeed
    }
}
