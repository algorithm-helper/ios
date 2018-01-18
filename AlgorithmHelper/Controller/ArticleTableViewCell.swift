//
//  ArticleTableViewCell.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-17.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
