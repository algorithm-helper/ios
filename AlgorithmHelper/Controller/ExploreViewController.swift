//
//  ExploreViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit
import Firebase

class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let FirebaseStorageBucketURL = "gs://algorithm-helper-storage.appspot.com/categories"
    
    var imageArray = [UIImage(named: "CardsDataStructuresLists"),
                      UIImage(named: "CardsDataStructuresTrees"),
                      UIImage(named: "CardsDataStructuresHashing"),
                      UIImage(named: "CardsAlgorithmsSorting"),
                      UIImage(named: "CardsAlgorithmsSearching"),
                      UIImage(named: "CardsAlgorithmsGraphs")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ExploreView loaded")
//        initializeTopicViews()
    }
    
    // MARK: - Dynamically create UIImageView objects for each topic from Resources/index.plist
    func initializeTopicViews() {
        for category in ContentSingleton.instance().getCategoryList() {
            print(category.title)
            
            for topic in category.topicList {
                print(topic.title)
                print(topic.image)
            }
        }
    }

    
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
    
    // MARK: - Setup UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicViewCell", for: indexPath) as! TopicViewCell
        
        cell.topicImageView.image = imageArray[indexPath.row]
        cell.topicImageView.layer.cornerRadius = 15
        cell.topicImageView.clipsToBounds = true
        
        return cell
    }
}
