//
//  TouristProfileViewModel.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import DashTakeHomeLib
import CoreData

final class TouristProfileViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let loader: TouristInfoLoader
    
    private var page = 1
    
    init(loader: TouristInfoLoader) {
        self.loader = loader
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onTouristLoad: Observer<TouristDTO>?
    
    var reloadNewFetchRows: Observer<Int>?
    
    func loadTourist(){
        onLoadingStateChange?(true)
        loader.load(from: URL(string: EndPoints.tourist(page: page.description).getUrl() )!) { [weak self] result in
            if let touristInfo = try? result.get() {
                self?.onTouristLoad?(touristInfo)
                self?.reloadNewFetchRows?(touristInfo.info.count)
            }
            self?.onLoadingStateChange?(false)
        }
    }
    
    func loadNextPage(){
        page += 1
        loadTourist()
    }
    
    func getLoaderForDetail() -> TouristDetailsLoader {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader: TouristDetailsLoader = RemoteTouristInfoLoader(client: client)
        
        let storeURL = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathExtension("detail-store.sqlite")
        let store = try! CoreDataStore(storeURL: storeURL, modelName: "DetailStore")
        let localLoader = LocalDetailTouristLoader(store: store)
        
        return TouristDetailLoaderWithFallbackComposite(primary: TouristDetailsLoaderCacheDecorator(decoratee: loader, cache: localLoader), fallback: localLoader)
    }
}
