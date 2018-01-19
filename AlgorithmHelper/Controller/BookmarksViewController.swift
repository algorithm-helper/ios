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
    var selected = [0, 0, 0]
    
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
    
    // MARK: - Change tab to Explore when buttonGoToExplore pressed
    @IBAction func goToExploreButtonPressed(_ sender: UIButton) {
        tabBarController?.selectedIndex = 0;
    }
    
    // MARK: - Setup noBookmarksView
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
    
    // MARK: - Configure bookmarksTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bookmarks.instance().getBookmarksDict().count
    }
    
    // MARK: - Populate bookmarksTableView
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
    
    // MARK: - Prepare segue change to ArticleViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ArticleViewController
        dest.categoryIndex = selected[0]
        dest.topicIndex = selected[1]
        dest.articleIndex = selected[2]
    }
    
    // MARK: - Perform segue change to ArticleViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData: [String: Int] = bookmarksArray[indexPath.row]
        selected[0] = cellData["categoryIndex"]!
        selected[1] = cellData["topicIndex"]!
        selected[2] = cellData["articleIndex"]!
        performSegue(withIdentifier: "goToBookmarkedArticleView", sender: self)
    }
}
