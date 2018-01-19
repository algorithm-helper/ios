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
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellRowIndex = 0
    var categoryIndexSelected: Int = 0
    var topicIndexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Setup UITableView, give every cell row an index number
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
        return Content.instance().getCategoryList().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Avenir-Bold", size: 18)
        headerLabel.textColor = UIColor.black
        headerLabel.text = Content.instance().getCategoryList()[section].title
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: - Segue to Topic View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let dest = segue.destination as! TopicViewController
        dest.categoryIndex = categoryIndexSelected
        dest.topicIndex = topicIndexSelected
    }
    
    func performSegueToTopicViewController(categoryIndex: Int, topicIndex: Int) {
        categoryIndexSelected = categoryIndex
        topicIndexSelected = topicIndex
        performSegue(withIdentifier: "goToTopicView", sender: self)
    }
}
