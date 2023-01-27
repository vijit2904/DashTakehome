//
//  ManagedImageData.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import CoreData

@objc(ManagedImageData)
class ManagedImageData: NSManagedObject {
    @NSManaged var data: Data?
    @NSManaged var imageCache: ManagedImageCache
}

extension ManagedImageData {
    static func image(from data: Data, in context: NSManagedObjectContext) -> ManagedImageData {
        let managed = ManagedImageData(context: context)
        managed.data = data
        return managed
    }
    
}
