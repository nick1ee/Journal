//
//  JournalTableViewCell.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var journalImageView: UIImageView!
    
    @IBOutlet weak var journalTitle: UILabel!
    
    @IBOutlet weak var circleImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        circleImageView.layer.borderWidth = 0.5
        
        journalImageView.layer.shadowColor = UIColor.black.cgColor
        
        journalImageView.layer.opacity = 0.5
        
        journalImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        journalImageView.layer.shadowRadius = 5.0
        
        journalImageView.layer.masksToBounds = false
        
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * 8, height: journalImageView.frame.height))
        
        journalImageView.layer.shadowPath = shadowPath.cgPath
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
