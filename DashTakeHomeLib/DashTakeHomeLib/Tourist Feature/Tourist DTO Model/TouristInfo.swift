//
//  TouristInfo.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public struct TouristDTO: Equatable {
    public let pages: Int
    public let info: [TouristInfo]
    
    public init(pages: Int, info: [TouristInfo]) {
        self.pages = pages
        self.info = info
    }
}

public struct TouristInfo: Equatable {
    public let id: Int
    public let name: String?
    public let email: String?
    public let location: String?
    public let memberSince: Date
    
    public init(id: Int, name: String, email: String, location: String, memberSince: Date) {
        self.id = id
        self.name = name
        self.email = email
        self.location = location
        self.memberSince = memberSince
    }
}
