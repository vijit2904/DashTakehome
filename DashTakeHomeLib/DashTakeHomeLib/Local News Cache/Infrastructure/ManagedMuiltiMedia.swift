//
//  ManagedMuiltiMedia.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import CoreData

@objc(ManagedMuiltiMedia)
internal class ManagedMuiltiMedia: NSManagedObject {
    @NSManaged var title: String?
    @NSManaged var mediaDescription: String?
    @NSManaged var date: Date
    @NSManaged var imageUrl: URL?
    @NSManaged var newsFeed: ManagedNewsFeed    
}


extension ManagedMuiltiMedia {
    static func multiMedia(from localMuiltiMedia: [LocalMultiMedia], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localMuiltiMedia.map { local in
            let managed = ManagedMuiltiMedia(context: context)
            managed.title = local.title
            managed.mediaDescription = local.description
            managed.date = local.date
            managed.imageUrl = local.imageUrl
            return managed
        })
    }
    
    var local: LocalMultiMedia {
        return LocalMultiMedia(title: title,
                               description: mediaDescription,
                               imageUrl: imageUrl,
                               date: date)
    }
}
