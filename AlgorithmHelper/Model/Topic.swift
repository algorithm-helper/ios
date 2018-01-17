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
    var url: String = ""
    var image: String = ""
    var articleDict: [String: Article] = [String: Article]()
    
    init() {
        title = ""
        url = ""
        image = ""
        articleDict = [String: Article]()
    }
    
    init(title: String, url: String, image: String, articleDict: [String: Article]) {
        self.title = title
        self.url = url
        self.image = image
        self.articleDict = articleDict
    }
    
}
