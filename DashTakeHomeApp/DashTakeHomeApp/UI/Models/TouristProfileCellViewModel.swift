//
//  TouristProfileCellViewModel.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class TouristProfileCellViewModel {
    
    private let model: TouristInfo
    
    init(model: TouristInfo) {
        self.model = model
    }
    
   private var id: String {
        return model.id.description
    }
    
    var name: String? {
        return model.name
    }
    
    var email: String? {
        return model.email
    }
    
    var location: String? {
        return model.location
    }
    
    var memberSince: String {
        return model.memberSince.getStringDate()
    }
    
    var getDetailsUrl: URL {
        return URL(string: EndPoints.details(id: id).getUrl())!
    }
}
