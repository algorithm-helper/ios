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
    var articleList: [Article] = [Article]()
    
    init() {
        title = ""
        url = ""
        image = ""
        articleList = [Article]()
    }
    
    init(title: String, url: String, image: String, articleList: [Article]) {
        self.title = title
        self.url = url
        self.image = image
        self.articleList = articleList
    }
    
}
