//
//  MultiMedia.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public struct MultiMedia: Equatable {
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
