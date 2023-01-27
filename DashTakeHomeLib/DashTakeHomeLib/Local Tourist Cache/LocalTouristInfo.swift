//
//  LocalTouristInfo.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation

public struct LocalTouristInfo: Equatable {
    public let pages: Int
    public let id: Int
    public let name: String
    public let email: String
    public let location: String
    public let memberSince: Date
    
    public init(pages: Int, id: Int, name: String, email: String, location: String, memberSince: Date) {
        self.pages = pages
        self.id = id
        self.name = name
        self.email = email
        self.location = location
        self.memberSince = memberSince
    }
}
