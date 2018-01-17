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
    var url: String = ""
    var topicDict: [String: Topic] = [String: Topic]()
    
    init() {
        title = ""
        url = ""
        topicDict = [String: Topic]()
    }
    
    init(title: String, url: String, topicDict: [String: Topic]) {
        self.title = title
        self.url = url
        self.topicDict = topicDict
    }
    
}
