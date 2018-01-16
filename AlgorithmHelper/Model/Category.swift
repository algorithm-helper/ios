//
//  Category.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class Category: Encodable, Decodable {
    
    var title: String = ""
    var firebaseStorageURL: String = ""
    var topicList: [Topic] = [Topic]()
    
    init() {
        title = ""
        firebaseStorageURL = ""
        topicList = [Topic]()
    }
    
    init(title: String, firebaseStorageURL: String, topicList: [Topic]) {
        self.title = title
        self.firebaseStorageURL = firebaseStorageURL
        self.topicList = topicList
    }
    
}
