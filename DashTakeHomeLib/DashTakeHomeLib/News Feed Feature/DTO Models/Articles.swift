//
//  Articles.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public struct Articles: Equatable {
    public let title: String?
    public let description: String?
    public let location: String
    public let multiMedia: [MultiMedia]
    public let date: Date
    public let user: User
    public let noOfComments: Int
    
    public init(title: String?, description: String?, location: String, multiMedia: [MultiMedia], date: Date, user: User, noOfComments: Int) {
        self.title = title
        self.description = description
        self.location = location
        self.multiMedia = multiMedia
        self.date = date
        self.user = user
        self.noOfComments = noOfComments
    }
}
