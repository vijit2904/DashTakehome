//
//  File.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/27/23.
//

import CoreData

@objc(ManagedTouristDetail)
class ManagedTouristDetail: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var location: String
    @NSManaged var memberSince: Date
    @NSManaged var detailCache: ManagedTouristDetailCache
}

extension ManagedTouristDetail {
    static func tourist(from local: LocalTouristInfo, in context: NSManagedObjectContext) -> ManagedTouristDetail {
            let managed = ManagedTouristDetail(context: context)
            managed.name = local.name
            managed.email = local.email
            managed.location = local.location
            managed.memberSince = local.memberSince
            return managed
        }
}
