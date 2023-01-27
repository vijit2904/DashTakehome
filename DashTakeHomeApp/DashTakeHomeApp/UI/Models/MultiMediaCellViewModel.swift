//
//  MultiMediaCellViewModel.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class MultiMediaCellViewModel {
    typealias Observer<T> = (T)-> Void
    
    private var task: ImageDataLoaderTask?
    private let model: MultiMedia
    private let imageLoader: ImageDataLoader
    
    init(model: MultiMedia, imageLoader: ImageDataLoader) {
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
    
    var imageUrl: URL? {
        return model.imageUrl
    }
    
    var memberSince: String {
        return model.date.getStringDate()
    }

    var onImageLoad: Observer<Data>?
    var onImageLoadingStateChange: Observer<Bool>?
    
    func loadImgData() {
        guard let imgUrl = model.imageUrl else {
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
