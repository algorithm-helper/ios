//
//  TopicViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categoryIndex: Int = 0
    var topicIndex: Int = 0
    var topicTitle: String = ""
    var numRows: Int = 0
    
    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TopicViewController loaded")
        
        // Set this TopicViewController as the delegate and dataSource to the articleTableView:
        articleTableView.delegate = self
        articleTableView.dataSource = self
        
        topicTitle = ContentSingleton.instance().getCategoryList()[categoryIndex].topicList[topicIndex].title
        numRows = ContentSingleton.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList.count
        self.navigationItem.title = topicTitle
        
        print("\(categoryIndex) \(topicIndex)")
    }
    
    // MARK: - Setup UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.articleLabel.text = ContentSingleton.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[indexPath.row].title
        return cell
    }
    
}
