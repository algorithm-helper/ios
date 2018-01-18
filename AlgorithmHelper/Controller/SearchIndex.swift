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
    
    private var trie = Trie<Dictionary<String, Int>>()
    
    private static let searchIndexSingleton = SearchIndex()
    
    static func instance() -> SearchIndex {
        return searchIndexSingleton
    }
    
    func initializeSearchIndex() {
        for categoryIndex in 0..<Content.instance().getCategoryList().count {
            for topicIndex in 0..<Content.instance().getCategoryList()[categoryIndex].topicList.count {
                for articleIndex in 0..<Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList.count {
                    var articleKey = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[articleIndex].url
                    
                    // Strip the key of hyphen characters:
                    articleKey = articleKey.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
                    
                    // If this key is already contained in the trie (for example with multiple articles named "introduction"
                    // then append a random number to the end of key:
                    if trie.contains(key: articleKey) {
                        articleKey.append(String(Int(arc4random())))
                    }
                    
                    trie.put(key: articleKey, val: ["categoryIndex": categoryIndex,
                                                    "topicIndex": topicIndex,
                                                    "articleIndex": articleIndex])
                }
            }
        }
    }
    
    // TODO: - Get search results
    func getSearchResults(key: String) -> [[String: Int]]? {
        var results = [[String: Int]]()
        for key in trie.getKeysWithPrefix(prefix: key) {
            results.append(trie.get(key: key)!)
        }
        return results
    }
    
    func getKeysWithPrefix(key: String) -> [String]? {
        return trie.getKeysWithPrefix(prefix: key)
    }
}
