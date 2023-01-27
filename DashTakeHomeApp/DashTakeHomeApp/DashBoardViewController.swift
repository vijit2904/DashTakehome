//
//  DashBoardViewController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import UIKit
import DashTakeHomeLib
import CoreData

class DashBoardViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.isTranslucent = false
        tabBar.tintColor = .label
        addTabItems()
    }
    

    private func addTabItems(){
        let vcOne: NewsTableViewController = composeUIForNewsTableView()
        let vcTwo: TouristProfileTableViewController = composeUIForTouristprofileTableView()
        viewControllers = [vcOne, vcTwo]
    }

    private func composeUIForNewsTableView() -> NewsTableViewController {
        
        let imgLoader = RemoteImageDataLoader(client: makeRemoteClient)
        let localImgLoader = LocalImageDataLoader(store: imageDataStore)
        
        let newsloader = RemoteNewsFeedLoader(client: makeRemoteClient)
        let localNewsLoader = LocalNewsFeedloader(store: localNewsStore)
        
        
        let newTVC = NewsUIComposer.newsFeedComposedWith(newsLoader: NewsLoaderWithFallbackComposite(primary:
                                                                                                        NewsLoaderCacheDecorator(decoratee: newsloader,
                                                                                                                                       cache: localNewsLoader),
                                                                                                     fallback: localNewsLoader),
                                                         imageLoader: ImageDataLoaderWithFallbackComposite(primary: localImgLoader,
                                                                                                           fallback:     ImageDataLoaderCacheDecorator(decoratee: imgLoader,
                                                                                                            cache: localImgLoader)))
        addItemForTab(newTVC, title: "News", imageName: "newspaper", selectedImageName: "newspaper.fill")
        return newTVC
    }
    
    private func addItemForTab(_ tVC: UITableViewController, title: String, imageName: String, selectedImageName: String) {
        
        tVC.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), selectedImage: UIImage(systemName:selectedImageName))
    }
    
    private lazy var makeRemoteClient: HTTPClient = {
        return URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var imageDataStore: ImageDataStore = {
        let storeURL = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathExtension("image-store.sqlite")
       return try! CoreDataImageStore(storeURL: storeURL)
    }()
    
    private lazy var localNewsStore: NewsFeedStore = {
        let storeURL = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathExtension("news-store.sqlite")
       return try! CoreDataStore(storeURL: storeURL, modelName: "NewFeedStore")
    }()
    
    private lazy var localTouristStore: TouristDataStore = {
        let storeURL = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathExtension("tourist-store.sqlite")
       return try! CoreDataStore(storeURL: storeURL, modelName: "TouristStore")
    }()
    
    private func composeUIForTouristprofileTableView() -> TouristProfileTableViewController {
        
        let touristloader = RemoteTouristInfoLoader(client: makeRemoteClient)
        let localTouristLoader = LocalTouristLoader(store: localTouristStore)
        
        let tpVC = TouristProfileUIComposer.touristProfileComposedWith(touristInfoLoader: TouristLoaderWithFallbackComposite(primary: TouristLoaderCacheDecorator(decoratee: touristloader,
                                                                                                                        cache: localTouristLoader),
                                                                                                                             fallback: localTouristLoader))
        addItemForTab(tpVC, title: "Tourist", imageName: "suitcase.rolling", selectedImageName: "suitcase.rolling.fill")
        return tpVC
    }
}
