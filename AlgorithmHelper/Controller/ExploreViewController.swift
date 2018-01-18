//
//  ExploreViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit
import Firebase

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let FirebaseStorageBucketURL = "gs://algorithm-helper-storage.appspot.com/categories"
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ExploreView loaded")
        tableView.delegate = self
        tableView.dataSource = self
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
    
    // MARK: - Setup UITableView, give every cell row an index number
    var cellRowIndex = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        cell.index = cellRowIndex
        cell.parent = self
        cellRowIndex += 1
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContentSingleton.instance().getCategoryList().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Avenir-Bold", size: 18)
        headerLabel.textColor = UIColor.black
        headerLabel.text = ContentSingleton.instance().getCategoryList()[section].title
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: - Segue to Topic View Controller
    func performSegueToTopicViewController(categoryIndex: Int, topicIndex: Int) {
        performSegue(withIdentifier: "goToTopicViewController", sender: self)
        print("\(categoryIndex) \(topicIndex)")
    }
}
