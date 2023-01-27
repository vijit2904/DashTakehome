//
//  NewsFeedApiModel.swift
//  DashTakeHomeLib
//
//  Created by Vijit Munjal on 1/24/23.
//

import Foundation

struct NewsFeedApiModel: Decodable {
    let page: Int
    let per_page: Int
    let totalrecord: Int
    let total_pages: Int
    let data: [NewsData]
}

struct NewsData: Decodable {
    let id: Int
    let title: String?
    let description: String?
    let location: String
    let multiMedia: [NewsMultiMedia]
    let createdat: Date
    let user: NewsUser
    let commentCount: Int
}

struct NewsUser: Decodable {
    let userid: Int
    let name: String
    let profilepicture: URL
}

struct NewsMultiMedia: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let description: String?
    let url: URL
    let createat: Date
}
