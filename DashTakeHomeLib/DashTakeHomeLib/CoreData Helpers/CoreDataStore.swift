//
//  CoreDataNewsStore.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation
import CoreData

public final class CoreDataStore {
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Swift.Error {
        case modelMissing
        case failedToLoadStore(Swift.Error)
    }
    
    public init(storeURL: URL, modelName: String) throws {
        guard let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataStore.self)) else {
            throw StoreError.modelMissing
        }
        
        do {
            container = try NSPersistentContainer.load(modelName: modelName, model: model, url: storeURL)
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

extension CoreDataStore: NewsFeedStore {
    public func insert(_ news: [LocalNewsFeed], url: URL, completion: @escaping InsertionCompletion) {
        perform { context in
            completion(Result {
                let managedCahce = try ManagedNewsCache.newUniqueInstance(for: url, in: context)
                managedCahce.url = url
                managedCahce.newsFeed = ManagedNewsFeed.news(from: news, in: context)
                try context.save()
            })
        }
    }
    
    public func retrieve(with url: URL, completion: @escaping RetrievalCompletion) {
        perform { context in
            completion(Result {
                try ManagedNewsCache.find(with: url, in: context).map {
                    return CachedNews(news: $0.localNewsFeed,
                                               url: $0.url)
                }
            })
        }
    }
}


extension CoreDataStore: TouristDataStore {
    public func insert(_ tourist: [LocalTouristInfo], url: URL, completion: @escaping (InsertionResult) -> Void) {
        perform { context in
            completion( Result {
                let managedCahce = try ManagedTouristCache.newUniqueInstance(for: url, in: context)
                managedCahce.url = url
                managedCahce.tourist = ManagedTourist.tourist(from: tourist, in: context)
                try context.save()
            })
        }
    }
    
    public func retrieve(with url: URL, completion: @escaping (TouristDataStore.RetrievalResult) -> Void) {
        perform { context in
            completion( Result {
                try ManagedTouristCache.find(with: url, in: context).map {
                    return CachedTourist(tourist: $0.localTourist,
                                         url: $0.url)
                }
            })
        }
    }
}


extension CoreDataStore: TouristDetailDataStore {
    public func insert(_ tourist: LocalTouristInfo, url: URL, completion: @escaping (InsertionResult) -> Void) {
        perform { context in
            completion( Result {
                let managedCahce = try ManagedTouristDetailCache.newUniqueInstance(for: url, in: context)
                managedCahce.url = url
                managedCahce.detail = ManagedTouristDetail.tourist(from: tourist, in: context)
                try context.save()
            })
        }
    }
    
    public func retrieve(with url: URL, completion: @escaping (TouristDetailDataStore.RetrievalResult) -> Void) {
        perform { context in
            completion( Result {
              return  try ManagedTouristDetailCache.find(with: url, in: context).map {
                    return CachedDetailTourist(tourist: $0.localTourist,
                                         url: $0.url)
                }
            })
        }
    }
    
    
}
