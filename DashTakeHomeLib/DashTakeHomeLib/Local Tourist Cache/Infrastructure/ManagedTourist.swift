//
//  ManagedTourist.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/26/23.
//

import CoreData

@objc(ManagedTourist)
class ManagedTourist: NSManagedObject {
    @NSManaged var pages: Int
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var location: String
    @NSManaged var memberFrom: Date
    @NSManaged var touristCache: ManagedTouristCache
}

extension ManagedTourist {
    static func tourist(from loaclTouristInfo: [LocalTouristInfo], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: loaclTouristInfo.map { local in
            let managed = ManagedTourist(context: context)
            managed.pages = local.pages
            managed.id = local.id
            managed.name = local.name
            managed.email = local.email
            managed.location = local.location
            managed.memberFrom = local.memberSince
            return managed
        })
    }
    
    var loaclTouristInfo: LocalTouristInfo {
        return LocalTouristInfo(pages: pages,
                                id: id,
                                name: name,
                                email: email,
                                location: location,
                                memberSince: memberFrom)
    }
}
