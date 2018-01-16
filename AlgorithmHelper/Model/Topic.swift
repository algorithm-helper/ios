//
//  Topic.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class Topic: Encodable, Decodable {
    
    var title: String = ""
    var firebaseStorageURL: String = ""
    var parentCategory: String = ""
    var articleList: [Article] = [Article]()
    
    init() {
        title = ""
        firebaseStorageURL = ""
        parentCategory = ""
        articleList = [Article]()
    }
    
    init(title: String, firebaseStorageURL: String, parentCategory: String, articleList: [Article]) {
        self.title = title
        self.firebaseStorageURL = firebaseStorageURL
        self.parentCategory = parentCategory
        self.articleList = articleList
    }
    
}
