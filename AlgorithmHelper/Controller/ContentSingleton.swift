//
//  ContentSingleton.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class ContentSingleton {
    
    private var categoryDict = Dictionary<String, Category>()
    
    private static let contentSingletonInstance = ContentSingleton()
    
    static func instance() -> ContentSingleton {
        return contentSingletonInstance
    }
    
    func initializeData() {
        if let url = Bundle.main.url(forResource:"index", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let categories = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [[String: Any]]
                
                for category in categories {
                    let title = category["title"] as! String
                    let url = category["category"] as! String
                    var topicDict = Dictionary<String, Topic>()
                    
                    let topicList = category["topics"] as! [[String: Any]]
                    for topic in topicList {
                        let title = topic["title"] as! String
                        let url = topic["topic"] as! String
                        let image = topic["image"] as! String
                        var articleDict = Dictionary<String, Article>()
                            
                        let articleList = topic["articles"] as! [[String: Any]]
                        for article in articleList {
                            let title = article["title"] as! String
                            let url = article["article"] as! String
                            let description = article["description"] as! String
                            articleDict[url] = Article(title: title, url: url, description: description, isBookmarked: false)
                        }
                        topicDict[url] = Topic(title: title, url: url, image: image, articleDict: articleDict)
                    }
                    categoryDict[url] = Category(title: title, url: url, topicDict: topicDict)
                }
            } catch {
                print(error)
                print("Error: Problem serializing the index.plist file.")
            }
        } else {
            print("Error: File not found, cannot initialize ContentSingleton data.")
        }
    }
    
    func getCategory(categoryTitle: String) -> Category {
        return categoryDict[categoryTitle]!
    }
    
    func getTopic(categoryTitle: String, topicTitle: String) -> Topic {
        return categoryDict[categoryTitle]!.topicDict[topicTitle]!
    }
    
    func getArticle(categoryTitle: String, topicTitle: String, articleTitle: String) -> Article {
        return categoryDict[categoryTitle]!.topicDict[topicTitle]!.articleDict[articleTitle]!
    }
}
