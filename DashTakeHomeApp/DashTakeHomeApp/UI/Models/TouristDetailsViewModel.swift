//
//  TouristDetailsViewModel.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import DashTakeHomeLib

final class TouristDetailsViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let loader: TouristDetailsLoader
    private let url: URL
    
    init(loader: TouristDetailsLoader, url: URL) {
        self.loader = loader
        self.url = url
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onTouristLoad: Observer<TouristInfo>?
    
    func loadTourist(){
        onLoadingStateChange?(true)
        loader.load(from: url) { [weak self] result in
            if let touristInfo = try? result.get() {
                self?.onTouristLoad?(touristInfo)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
