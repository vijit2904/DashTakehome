//
//  TouristApiModel.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

struct TouristApiModel: Decodable{
    let page: Int
    let per_page: Int
    let totalrecord: Int
    let total_pages: Int
    let data: [TouristData]
}

struct TouristData: Decodable {
    let id: Int
    let tourist_name: String?
    let tourist_email: String?
    let tourist_location: String?
    let createdat: Date
}
