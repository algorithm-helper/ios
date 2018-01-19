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
    var url: String = ""
    var isBookmarked: Bool = false
    
    init() {
        title = ""
        url = ""
        isBookmarked = false
    }
    
    init(title: String, url: String, isBookmarked: Bool) {
        self.title = title
        self.url = url
        self.isBookmarked = isBookmarked
    }
}
