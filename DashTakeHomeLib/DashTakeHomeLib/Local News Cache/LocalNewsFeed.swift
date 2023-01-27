//
//  LocalNewsFeed.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

public struct LocalNewsFeed: Equatable {
    
    public let pages: Int
    public let title: String?
    public let description: String?
    public let location: String
    public let multiMedia: [LocalMultiMedia]
    public let date: Date
    public let user: LocalUser
    public let noOfComments: Int
    
    public init(pages: Int, title: String?, description: String?, location: String, multiMedia: [LocalMultiMedia], date: Date, user: LocalUser, noOfComments: Int) {
        self.pages = pages
        self.title = title
        self.description = description
        self.location = location
        self.multiMedia = multiMedia
        self.date = date
        self.user = user
        self.noOfComments = noOfComments
    }
}

public struct LocalMultiMedia: Equatable {
    public let title: String?
    public let description: String?
    public let imageUrl: URL?
    public let date: Date
    
    public init(title: String?, description: String?, imageUrl: URL?, date: Date) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.date = date
    }
}

public struct LocalUser: Equatable {
    public let userName: String?
    public let profileImgUrl: URL?
    
    public init(userName: String?, profileImgUrl: URL?) {
        self.userName = userName
        self.profileImgUrl = profileImgUrl
    }
}
