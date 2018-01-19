//
//  SearchViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchNoneView: UIView!
    
    var searchResultRows = 0
    var searchResults = [[String: Int]]()
    var selected = [0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        hideKeyboard()
    }
    
    // MARK: - Show searchNoneView only if the searchBar is empty
    override func viewDidAppear(_ animated: Bool) {
        searchNoneView.isHidden = searchBar.text?.count != 0
    }
    
    // MARK: - Control keyboard
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(SearchViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Normalize the text in the searchBar, update search results from SearchIndex singleton
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1 {
            let searchKey = searchText.replacingOccurrences(of: "[^0-9a-zA-Z]", with: "",
                                                            options: .regularExpression, range: nil).lowercased()
            searchResults = SearchIndex.instance().getSearchResults(key: searchKey)!
            searchResultRows = searchResults.count
            searchNoneView.isHidden = true
        } else {
            searchResults = []
            searchResultRows = 0
            searchNoneView.isHidden = false
        }
        
        searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultRows
    }
    
    // MARK: - Update cell in the searchTableView with the correct info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell") as! SearchTableViewCell
        let articleTitle = Content.instance().getArticle(categoryIndex: searchResults[indexPath.row]["categoryIndex"]!,
                                                         topicIndex: searchResults[indexPath.row]["topicIndex"]!,
                                                         articleIndex: searchResults[indexPath.row]["articleIndex"]!).title
        let topicTitle = Content.instance().getTopic(categoryIndex: searchResults[indexPath.row]["categoryIndex"]!,
                                                     topicIndex: searchResults[indexPath.row]["topicIndex"]!).title
        let categoryTitle = Content.instance().getCategory(categoryIndex: searchResults[indexPath.row]["categoryIndex"]!).title
        cell.searchResultLabel.text = articleTitle
        cell.searchResultLabelSecondary.text = "\(categoryTitle) › \(topicTitle)"
        return cell
    }
    
    // MARK: - Update segue's destination category/topic/article indices, reset the tableView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ArticleViewController
        dest.categoryIndex = selected[0]
        dest.topicIndex = selected[1]
        dest.articleIndex = selected[2]
    }
    
    // MARK: - Perform segue to the ArticleViewController
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cellData: [String: Int] = searchResults[indexPath.row]
        selected[0] = cellData["categoryIndex"]!
        selected[1] = cellData["topicIndex"]!
        selected[2] = cellData["articleIndex"]!
        searchBar.text? = ""
        searchResults = []
        searchResultRows = 0
        tableView.reloadData()
        performSegue(withIdentifier: "goToSearchedArticleView", sender: self)
    }
}

