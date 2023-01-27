//
//  TouristDetailLoaderWithFallbackComposite.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

class TouristDetailLoaderWithFallbackComposite: TouristDetailsLoader {
    
    private let primary: TouristDetailsLoader
    private let fallback: TouristDetailsLoader
    
    init(primary: TouristDetailsLoader, fallback: TouristDetailsLoader) {
        self.primary  = primary
        self.fallback = fallback
    }
    
    
    func load(from url: URL, completion: @escaping (TouristDetailsLoader.Result) -> Void) {
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
