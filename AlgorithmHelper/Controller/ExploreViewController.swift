//
//  ExploreViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit
import Firebase

class ExploreViewController: UIViewController, UITableViewDataSource {

    let FirebaseStorageBucketURL = "gs://algorithm-helper-storage.appspot.com/categories"
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ExploreView loaded")
        
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
    
    // MARK: - Setup UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContentSingleton.instance().getCategoryList().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContentSingleton.instance().getCategoryList()[section].title
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Avenir-Bold", size: 18)!
    }
    
}
