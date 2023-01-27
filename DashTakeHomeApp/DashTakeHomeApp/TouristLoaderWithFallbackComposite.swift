//
//  TouristLoaderWithFallbackComposite.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

class TouristLoaderWithFallbackComposite: TouristInfoLoader {
    
    private let primary: TouristInfoLoader
    private let fallback: TouristInfoLoader
    
    init(primary: TouristInfoLoader, fallback: TouristInfoLoader) {
        self.primary  = primary
        self.fallback = fallback
    }
    
    
    func load(from url: URL, completion: @escaping (TouristInfoLoader.Result) -> Void) {
        primary.load(from: url) { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.load(from: url, completion: completion)
            }
        }
    }
}
