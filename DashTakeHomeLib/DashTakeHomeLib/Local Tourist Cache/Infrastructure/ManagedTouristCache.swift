//
//  ManagedTouristCache.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import CoreData

@objc(ManagedTouristCache)
class ManagedTouristCache: NSManagedObject {
    @NSManaged var url: URL
    @NSManaged var tourist: NSOrderedSet
}

extension ManagedTouristCache {
    
    static func find(with url: URL, in context: NSManagedObjectContext) throws -> ManagedTouristCache?{
        let request = NSFetchRequest<ManagedTouristCache>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedTouristCache.url), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func newUniqueInstance(for url: URL, in context: NSManagedObjectContext) throws -> ManagedTouristCache {
        try find(with: url, in: context).map(context.delete)
        return ManagedTouristCache(context: context)
    }
    
    var localTourist: [LocalTouristInfo] {
        return tourist.compactMap{( $0 as? ManagedTourist)?.loaclTouristInfo }
    }
    
}
