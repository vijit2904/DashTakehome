//
//  User.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

public struct User: Equatable {
    public let userName: String?
    public let profileImgUrl: URL?
    
   public init(userName: String?, profileImgUrl: URL?) {
        self.userName = userName
        self.profileImgUrl = profileImgUrl
    }
}
