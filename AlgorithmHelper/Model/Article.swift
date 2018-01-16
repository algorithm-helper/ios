//
//  Article.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class Article: Encodable, Decodable {
    
    var title: String = ""
    var firebaseStorageURL: String = ""
    var parentTopic: String = ""
    var isBookmarked: Bool = false
    
    init() {
        title = ""
        firebaseStorageURL = ""
        parentTopic = ""
        isBookmarked = false
    }
    
    init(title: String, firebaseStorageURL: String, parentTopic: String, isBookmarked: Bool) {
        self.title = title
        self.firebaseStorageURL = firebaseStorageURL
        self.parentTopic = parentTopic
        self.isBookmarked = isBookmarked
    }
}
