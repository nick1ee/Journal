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

    @IBOutlet weak var journalImageContainerView: UIView!
    
    @IBOutlet weak var journalTitle: UILabel!
    
    @IBOutlet weak var circleImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        circleImageView.layer.borderWidth = 0.5
        
        journalImageContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        
        journalImageContainerView.layer.shadowOpacity = 1
        
        journalImageContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        journalImageContainerView.layer.shadowRadius = 5.0
        
        journalImageView.layer.cornerRadius = 8

        journalImageView.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
