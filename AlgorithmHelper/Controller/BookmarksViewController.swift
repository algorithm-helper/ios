//
//  BookmarksViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    @IBOutlet weak var buttonGoToExplore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("BookmarksView loaded")
        
        // Make button borders round:
        buttonGoToExplore.layer.cornerRadius = 0.025 * buttonGoToExplore.bounds.size.width
    
    }
    
    
    
    
    
    
    
    
    
}
