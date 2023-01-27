//
//  File2.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/27/23.
//

import CoreData

@objc(ManagedTouristDetailCache)
class ManagedTouristDetailCache: NSManagedObject {
    @NSManaged var url: URL
    @NSManaged var detail: ManagedTouristDetail
}

extension ManagedTouristDetailCache {
    
    static func find(with url: URL, in context: NSManagedObjectContext) throws -> ManagedTouristDetailCache?{
        let request = NSFetchRequest<ManagedTouristDetailCache>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedTouristDetailCache.url), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func newUniqueInstance(for url: URL, in context: NSManagedObjectContext) throws -> ManagedTouristDetailCache {
        try find(with: url, in: context).map(context.delete)
        return ManagedTouristDetailCache(context: context)
    }
    
    var localTourist: LocalTouristInfo {
        return LocalTouristInfo(pages: 0,
                                id: 0,
                                name: detail.name,
                                email: detail.email,
                                location: detail.location,
                                memberSince: detail.memberSince)
    }
    
}
