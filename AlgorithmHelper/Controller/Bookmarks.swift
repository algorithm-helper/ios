//
//  Bookmarks.swift
//  AlgorithmHelper
//
//  Provides a singleton instance of Bookmarks, which contains a Dictionary to
//  each Article and their associated category/topic/article indices.
//
//  Created by Eric Liu on 2018-01-18.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation
import UIKit

class Bookmarks {
    
    private var bookmarksDict = [String: [String: Int]]()
    
    private static let bookmarksSingleton = Bookmarks()
    
    static func instance() -> Bookmarks {
        return bookmarksSingleton
    }
    
    func getBookmarksDict() -> [String: [String: Int]] {
        return bookmarksDict
    }
    
    func getBookmarksIndices(key: String) -> [String: Int] {
        return bookmarksDict[key]!
    }
    
    func getBookmarksArray() -> [[String: Int]] {
        var bookmarksArray = [[String: Int]]()
        
        for (_, value) in bookmarksDict {
            bookmarksArray.append(["categoryIndex": value["categoryIndex"]!,
                                   "topicIndex": value["topicIndex"]!,
                                   "articleIndex": value["articleIndex"]!])
        }
        
        return bookmarksArray
    }
    
    func addBookmark(key: String, categoryIndex: Int, topicIndex: Int, articleIndex: Int) {
        bookmarksDict[key] = ["categoryIndex": categoryIndex,
                              "topicIndex": topicIndex,
                              "articleIndex": articleIndex]
    }
    
    func deleteBookmark(key: String) {
        bookmarksDict[key] = nil
    }
    
    func removeBookmark(key: String) -> [String: Int] {
        return bookmarksDict.removeValue(forKey: key)!
    }
    
    // TODO: - Save the data of BookmarksSingleton on close of the app
    func saveData() {
        
    }
}
