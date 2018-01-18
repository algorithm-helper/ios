//
//  ArticleViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit
import Firebase

class ArticleViewController: UIViewController {
    
    let FirebaseStorageBucketURL = "gs://algorithm-helper-storage.appspot.com/categories"
    
    var categoryIndex: Int = 0
    var topicIndex: Int = 0
    var articleIndex: Int = 0
    var categoryURL: String = ""
    var topicURL: String = ""
    var articleURL: String = ""
    var articleTitle: String = ""
    
    @IBOutlet weak var articleBody: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryURL = ContentSingleton.instance().getCategoryList()[categoryIndex].url
        topicURL = ContentSingleton.instance().getCategoryList()[categoryIndex].topicList[topicIndex].url
        articleURL = ContentSingleton.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[articleIndex].url
        
        articleTitle = ContentSingleton.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[articleIndex].title
        self.navigationItem.title = articleTitle
        
        print("Article Index: \(categoryIndex) \(topicIndex) \(articleIndex)")
        
        setArticleContent()
    }
    
    // MARK: - Create Firebase URLS from article title, topic title, and category title
    func createFirebaseURL(categoryURL: String, topicURL: String, articleURL: String) -> String {
        return "\(FirebaseStorageBucketURL)/\(categoryURL)/\(topicURL)/\(articleURL).md"
    }
    
    // MARK: - Get article content from Firebase
    func getArticleMarkdownFromFirebase(url: String) {
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error!)
            } else {
                let str = data?.utf8String
                print(str!)
            }
        }
    }
    
    // MARK: - Set article content
    func setArticleContent() {
        let url = createFirebaseURL(categoryURL: categoryURL, topicURL: topicURL, articleURL: articleURL)
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error!)
            } else {
                let str = data?.utf8String
                self.articleBody.text = str
            }
        }
    }
}
