//
//  SettingsViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet var settingsTableVIew: UITableView!
    let urls = ["https://www.algorithmhelper.com",
                "https://www.algorithmhelper.com/contact",
                "https://www.algorithmhelper.com/terms-and-conditions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableVIew.delegate = self
    }
    
    // MARK: - Configure settingsTableView to have their corresponding URLs
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = urls[indexPath.row]
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Configure settingsTableView header to have a custom header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let headerLabel = UILabel(frame: CGRect(x: 18, y: 13, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Avenir-Bold", size: 16)
        headerLabel.textColor = UIColor.black
        headerLabel.text = "General"
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: - Configure settingsTableView footer to have a custom footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 8, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Avenir", size: 14)
        headerLabel.textColor = UIColor.black
        headerLabel.text = "Made with ☕ by Eric Liu."
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
}
