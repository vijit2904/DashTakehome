//
//  ManagedImageCache.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import CoreData

@objc(ManagedImageCache)
class ManagedImageCache: NSManagedObject {
    @NSManaged var url: URL
    @NSManaged var imageData: ManagedImageData
}

extension ManagedImageCache {
    
    static func find(with url: URL, in context: NSManagedObjectContext) throws -> ManagedImageCache? {
        let request = NSFetchRequest<ManagedImageCache>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedImageCache.url), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func newUniqueInstance(for url: URL, in context: NSManagedObjectContext) throws -> ManagedImageCache {
        try find(with: url, in: context).map(context.delete)
        return ManagedImageCache(context: context)
    }
}

