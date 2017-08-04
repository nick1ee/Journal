//
//  JournalViewController.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var defaultImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        defaultImageView.tintColor = UIColor.white
        
    }

}
