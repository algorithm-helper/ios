//
//  BookmarksViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var buttonGoToExplore: UIButton!
    @IBOutlet weak var noBookmarksView: UIView!
    @IBOutlet weak var bookmarksTableView: UITableView!
    
    var bookmarksArray = [[String: Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarksTableView.dataSource = self
        bookmarksTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNoBookmarksView()
        bookmarksArray = Bookmarks.instance().getBookmarksArray()
        bookmarksTableView.reloadData()
    }
    
    @IBAction func goToExploreButtonPressed(_ sender: UIButton) {
        tabBarController?.selectedIndex = 0;
    }
    
    // MARK: - Setup no bookmarks view, i.e. view that is shown when no bookmarks have been added yet
    func setupNoBookmarksView() {
        if Bookmarks.instance().getBookmarksDict().isEmpty {
            bookmarksTableView.isHidden = true
            noBookmarksView.isHidden = false
            buttonGoToExplore.layer.cornerRadius = 0.025 * buttonGoToExplore.bounds.size.width
        } else {
            bookmarksTableView.isHidden = false
            noBookmarksView.isHidden = true
        }
    }
    
    // MARK: - Setup table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bookmarks.instance().getBookmarksDict().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksTableViewCell", for: indexPath) as! BookmarksTableViewCell
        let cellData: [String: Int] = bookmarksArray[indexPath.row]
        cell.bookmarksLabel.text = Content.instance()
            .getCategoryList()[cellData["categoryIndex"]!]
            .topicList[cellData["topicIndex"]!]
            .articleList[cellData["articleIndex"]!]
            .title
        return cell
    }
    
    // MARK: - Prepare and perform segue change to ArticleView
    var categoryIndexSelected: Int = 0
    var topicIndexSelected: Int = 0
    var articleIndexSelected: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ArticleViewController
        dest.categoryIndex = categoryIndexSelected
        dest.topicIndex = topicIndexSelected
        dest.articleIndex = articleIndexSelected
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData: [String: Int] = bookmarksArray[indexPath.row]
        categoryIndexSelected = cellData["categoryIndex"]!
        topicIndexSelected = cellData["topicIndex"]!
        articleIndexSelected = cellData["articleIndex"]!
        performSegue(withIdentifier: "goToBookmarkedArticleView", sender: self)
    }
}
