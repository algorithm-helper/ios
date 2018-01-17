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
    var description: String = ""
    var isBookmarked: Bool = false
    
    init() {
        title = ""
        url = ""
        description = ""
        isBookmarked = false
    }
    
    init(title: String, url: String, description: String, isBookmarked: Bool) {
        self.title = title
        self.url = url
        self.description = description
        self.isBookmarked = isBookmarked
    }
}
