//
//  CoreDataImageStore.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation
import CoreData

public final class CoreDataImageStore {
    
    private static let modelName = "ImageDataStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataImageStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Swift.Error {
        case modelMissing
        case failedToLoadStore(Swift.Error)
    }
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataImageStore.model else {
            throw StoreError.modelMissing
        }
        
        do {
            container = try NSPersistentContainer.load(modelName: CoreDataImageStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch  {
            throw StoreError.failedToLoadStore(error)
        }
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        context.perform { [context] in
            action(context)
        }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}
    
extension CoreDataImageStore: ImageDataStore {
    
    public func insert(_ data: Data, url: URL, completion: @escaping (InsertionResult) -> Void) {
        perform { context in
            completion(Result {
                let cache = try ManagedImageCache.newUniqueInstance(for: url, in: context)
                cache.url = url
                cache.imageData = ManagedImageData.image(from: data, in: context)
                try context.save()
            })
        }
    }
    
    public func retrieve(dataForUrl: URL, completion: @escaping (RetrievalResult) -> Void) {
        perform { context in
            completion(Result {
                return try ManagedImageCache.find(with: dataForUrl, in: context)?.imageData.data
            })
        }
        
    }
}
