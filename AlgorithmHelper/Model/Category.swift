//
//  Category.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class Category {
    
    var title: String = ""
    var url: String = ""
    var topicList: [Topic] = [Topic]()
    
    init() {
        title = ""
        url = ""
        topicList = [Topic]()
    }
    
    init(title: String, url: String, topicList: [Topic]) {
        self.title = title
        self.url = url
        self.topicList = topicList
    }
    
}
