//
//  SearchViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var searchIndex = [[String: Int]]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNoSearchView()
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
    
    // MARK: - Setup no search view
    func setupNoSearchView() {
        searchTableView.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchTableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchTableView.isHidden = true
    }
}

