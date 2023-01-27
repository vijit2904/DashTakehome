//
//  ManagedNewsCache.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import CoreData

@objc(ManagedNewsCache)
class ManagedNewsCache: NSManagedObject {
    @NSManaged var url: URL
    @NSManaged var newsFeed: NSOrderedSet
}

extension ManagedNewsCache {
    
    static func find(with url: URL, in context: NSManagedObjectContext) throws -> ManagedNewsCache?{
        let request = NSFetchRequest<ManagedNewsCache>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedNewsCache.url), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func newUniqueInstance(for url: URL, in context: NSManagedObjectContext) throws -> ManagedNewsCache {
        try find(with: url, in: context).map(context.delete)
        return ManagedNewsCache(context: context)
    }
    
    var localNewsFeed: [LocalNewsFeed] {
        return newsFeed.compactMap{( $0 as? ManagedNewsFeed)?.local }
    }
}
