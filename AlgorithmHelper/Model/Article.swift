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
    
    init() {
        title = ""
        url = ""
    }
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
