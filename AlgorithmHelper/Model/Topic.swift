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
    var articleList: [Article] = [Article]()
    
    init() {
        title = ""
        firebaseStorageURL = ""
        articleList = [Article]()
    }
    
    init(title: String, firebaseStorageURL: String, articleList: [Article]) {
        self.title = title
        self.firebaseStorageURL = firebaseStorageURL
        self.articleList = articleList
    }
    
}
