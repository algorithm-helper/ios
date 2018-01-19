//
//  ArticleViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit
import Firebase
import Down
import SVProgressHUD

class ArticleViewController: UIViewController {
    
    let FirebaseStorageBucketURL = "gs://algorithm-helper-storage.appspot.com/ios"
    
    var categoryIndex: Int = 0
    var topicIndex: Int = 0
    var articleIndex: Int = 0
    var categoryURL: String = ""
    var topicURL: String = ""
    var articleURL: String = ""
    var articleTitle: String = ""
    var key = ""
    
    @IBOutlet weak var articleScrollView: UIScrollView!
    @IBOutlet weak var articleBookmark: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryURL = Content.instance().getCategoryList()[categoryIndex].url
        topicURL = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].url
        articleURL = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[articleIndex].url
        articleTitle = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[articleIndex].title
        key = "\(categoryURL)\(topicURL)\(articleURL)"
        self.navigationItem.title = articleTitle
        setArticleContent()
        setBookmark(forUpdate: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setBookmark(forUpdate: false)
    }
    
    // MARK: - Create Firebase URLS from article title, topic title, and category title
    func createFirebaseURL(categoryURL: String, topicURL: String, articleURL: String) -> String {
        return "\(FirebaseStorageBucketURL)/\(categoryURL)/\(topicURL)/\(articleURL).md"
    }
    
    // MARK: - Set article content
    func setArticleContent() {
        SVProgressHUD.show()
        let url = createFirebaseURL(categoryURL: categoryURL, topicURL: topicURL, articleURL: articleURL)
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error!)
            } else {
                let markdown = data?.utf8String
                let markdownFormatted = (markdown?.replacingOccurrences(of: "$", with: "`", options: .literal, range: nil))!
                let markdownView = try? DownView(frame: self.view.bounds, markdownString: markdownFormatted)
                markdownView?.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
                markdownView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.articleScrollView.addSubview(markdownView!)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: - Set article's bookmark
    func setBookmark(forUpdate: Bool) {
        if Content.instance().hasBookmark(categoryIndex: categoryIndex, topicIndex: topicIndex, articleIndex: articleIndex) {
            articleBookmark.image = UIImage(named: "IconBookmarkDark")
            
            if forUpdate {
                Bookmarks.instance().addBookmark(key: key, categoryIndex: categoryIndex, topicIndex: topicIndex, articleIndex: articleIndex)
            }
        } else {
            articleBookmark.image = UIImage(named: "IconBookmark")
            
            if forUpdate {
                Bookmarks.instance().deleteBookmark(key: key)
            }
        }
    }
    
    @IBAction func bookmarkPressed(_ sender: Any) {
        Content.instance().toggleBookmark(categoryIndex: categoryIndex, topicIndex: topicIndex, articleIndex: articleIndex)
        setBookmark(forUpdate: true)
    }
}
