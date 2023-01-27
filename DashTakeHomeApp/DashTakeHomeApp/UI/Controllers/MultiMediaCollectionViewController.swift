//
//  MultiMediaCollectionViewController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

class MultiMediaCollectionViewController: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    
    private var loadingControllers = [IndexPath: MultiMediaCollectionViewCellController]()
    
    var collectionModel = [MultiMediaCollectionViewCellController](){
        didSet { collectionView.reloadData() }
    }
    
    lazy var pageview: UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 0
        page.isUserInteractionEnabled = false
        page.tintColor = .label
        page.pageIndicatorTintColor = .gray
        page.currentPageIndicatorTintColor = .label
        return page
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        collectionView.register(MultiMediaCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MultiMediaCollectionViewCell.self))
        view.addConstraint(for: pageview, contentView: view)
    }

    private func layoutSetup(){
        collectionView.prefetchDataSource = self
        collectionView.allowsSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (collectionModel.count > 1) ? (pageview.numberOfPages = collectionModel.count) :  (pageview.numberOfPages = 0)
        return collectionModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionModel[indexPath.item].view(in: collectionView, indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageview.currentPage = indexPath.row
        cellController(forRowAt: indexPath).preload()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach{ indexPaths in
            cellController(forRowAt: indexPaths).preload()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }

    private func cellController(forRowAt indexPath: IndexPath) -> MultiMediaCollectionViewCellController {
        let controller = collectionModel[indexPath.item]
        loadingControllers[indexPath] = controller
        return controller
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath){
        loadingControllers[indexPath]?.cacelLoad()
        loadingControllers[indexPath] = nil
    }
}
