//
//  NewsArticleCellViewModel.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation
import DashTakeHomeLib

final class NewsArticleCellViewModel {
    typealias Observer<T> = (T)-> Void
    
    private var task: ImageDataLoaderTask?
    private let model: Articles
    private let imageLoader: ImageDataLoader
    
    init(model: Articles, imageLoader: ImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    var title: String? {
        return model.title
    }
    
    var description: String? {
        return model.description
    }
    
    var isTitleVisible: Bool {
        return !(model.title != nil)
    }
    
    var isDescriptionVisible: Bool {
        return !(model.description != nil)
    }
    
    var location: String? {
        return model.location
    }
    
    var multiMedia: [MultiMedia] {
        return model.multiMedia
        }
    
    var isMultiMediaVisible: Bool {
        return model.multiMedia.isEmpty
    }
    
    var date: String? {
        return model.date.getStringDate()
    }
    
    var noOfComments: String? {
        return model.noOfComments.description
    }
    
    var userName: String? {
        return model.user.userName
    }
    
    var onImageLoad: Observer<Data>?
    var onImageLoadingStateChange: Observer<Bool>?
    
    func getMultiMediaCellController() -> [MultiMediaCollectionViewCellController] {
        let imgLoader = self.imageLoader
        let cellController = multiMedia.map { media in
            MultiMediaCollectionViewCellController(viewModel: MultiMediaCellViewModel(model: media,
                                                                                      imageLoader: imgLoader))
        }
        
        return cellController
    }
    
    func loadImageData(){
        guard let imgUrl = model.user.profileImgUrl else {
            return
        }
        onImageLoadingStateChange?(true)
        task = imageLoader.loadImageData(from: imgUrl) { [weak self] result in
            guard self != nil else { return }
            self?.handle(result)
        }
    }
    
    private func handle(_ result: ImageDataLoader.Result) {
        if let imageData = (try? result.get()) {
            onImageLoad?(imageData)
        }
        onImageLoadingStateChange?(false)
    }
    
    func cancelImageLoadData() {
        task?.cancel()
        task = nil
    }
}
