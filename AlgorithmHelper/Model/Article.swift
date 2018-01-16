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
    var isBookmarked: Bool = false
    
    init() {
        title = ""
        firebaseStorageURL = ""
        isBookmarked = false
    }
    
    init(title: String, firebaseStorageURL: String, isBookmarked: Bool) {
        self.title = title
        self.firebaseStorageURL = firebaseStorageURL
        self.isBookmarked = isBookmarked
    }
}
