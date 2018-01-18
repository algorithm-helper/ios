//
//  SearchIndex.swift
//  AlgorithmHelper
//
//  Provides the singleton instance for the SearchIndex, builds up search index as an r-way trie.
//
//  Created by Eric Liu on 2018-01-18.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class SearchIndex {
    
    private static let searchIndexSingleton = SearchIndex()
    
    static func instance() -> SearchIndex {
        return searchIndexSingleton
    }
    
    func initializeSearchIndex() {
        
    }
    
    // TODO: - Get search results
    func getSearchResults(key: String) -> [[String: Int]] {
        return []
    }
}
