//
//  NewsData.swift
//  NewsApp
//
//  Created by user on 06.02.2021.
//

import Foundation
struct NewsData : Codable {
    let articles : [Articles]
    let totalResults : Int
    
}
struct Articles : Codable {
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let source : Source
}
struct Source : Codable {
    let name : String?
}
