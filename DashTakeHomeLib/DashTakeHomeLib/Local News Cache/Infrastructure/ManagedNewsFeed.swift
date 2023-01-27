//
//  ManagedNewsFeed.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import CoreData

@objc(ManagedNewsFeed)
class ManagedNewsFeed: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var pages: Int
    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var location: String
    @NSManaged var noOfComments: Int
    @NSManaged var date: Date
    @NSManaged var newsCache: ManagedNewsCache
    @NSManaged var user: ManagedNewsUser
    @NSManaged var multiMedia: NSOrderedSet
}


extension ManagedNewsFeed {
     static func news(from localFeed: [LocalNewsFeed], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localFeed.map { local in
            let managed = ManagedNewsFeed(context: context)
            managed.id = UUID()
            managed.pages = local.pages
            managed.title = local.title
            managed.desc  = local.description
            managed.location = local.location
            managed.multiMedia = ManagedMuiltiMedia.multiMedia(from: local.multiMedia, in: context)
            managed.date = local.date
            managed.user = ManagedNewsUser.user(from: local.user, in: context)
            managed.noOfComments = local.noOfComments
            return managed
        })
    }
    
    var local: LocalNewsFeed {
        return LocalNewsFeed(pages: pages,
                             title: title,
                             description: desc,
                             location: location,
                             multiMedia: (multiMedia.compactMap {( $0 as? ManagedMuiltiMedia)?.local }),
                             date: date,
                             user: user.local,
                             noOfComments: noOfComments)
    }
    
}
