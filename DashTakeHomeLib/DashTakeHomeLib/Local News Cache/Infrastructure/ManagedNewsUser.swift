//
//  ManagedNewsUser.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import CoreData

@objc(ManagedNewsUser)
class ManagedNewsUser: NSManagedObject {
    @NSManaged var userName: String?
    @NSManaged var profileImgUrl: URL?
    @NSManaged var newsFeed: ManagedNewsFeed
}

extension ManagedNewsUser {
    
    static func user(from localUser: LocalUser, in context: NSManagedObjectContext) -> ManagedNewsUser {
        let managed = ManagedNewsUser(context: context)
        managed.userName = localUser.userName
        managed.profileImgUrl = localUser.profileImgUrl
        return managed
    }

    
    var local: LocalUser {
        return LocalUser(userName: userName,
                         profileImgUrl: profileImgUrl)
    }
}
