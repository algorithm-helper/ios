//
//  ExploreViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit
import Firebase

class ExploreViewController: UIViewController {

    let FirebaseStorageBucketURL = "gs://algorithm-helper-storage.appspot.com/categories"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("ExploreView loaded")
        
        
        
        
        
    }
    
    // MARK: - Dynamically create UIImageView objects for each topic
    
    // MARK: - Create Firebase URLS from article title, topic title, and category title
    func createFirebaseURL(articleTitle: String, topicTitle: String, categoryTitle: String) -> String {
        return "\(FirebaseStorageBucketURL)/\(categoryTitle)/\(topicTitle)/\(articleTitle)"
    }
    
    // MARK: - Get article content from Firebase
    func getArticleMarkdownFromFirebase(categoryTitle: String, topicTitle: String, articleTitle: String) {
        let storageRef = Storage.storage().reference(forURL: "\(FirebaseStorageBucketURL)/\(categoryTitle)/\(topicTitle)/\(articleTitle).md")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error!)
            } else {
                let str = data?.utf8String
                print(str!)
            }
        }
    }
}
