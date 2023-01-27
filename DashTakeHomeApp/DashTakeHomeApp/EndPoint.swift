//
//  EndPoint.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation

enum EndPoints {
    case news(page: String)
    case tourist(page: String)
    case details(id: String)
    
     func getUrl() -> String {
        switch self {
        case let .news(page):
           return "http://restapi.adequateshop.com/api/Feed/GetNewsFeed?page=\(page)"
        case let .tourist(page):
            return "http://restapi.adequateshop.com/api/Tourist?page=\(page)"
        case let .details(id):
            return "http://restapi.adequateshop.com/api/Tourist/\(id)"
            
        }
    }
}
