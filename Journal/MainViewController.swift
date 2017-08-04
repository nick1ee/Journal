//
//  MainViewController.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var journalTableView: UITableView!
    
    var journals: [Journal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalTableView.estimatedRowHeight = 250
        
        journalTableView.rowHeight = UITableViewAutomaticDimension
        
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalTableViewCell
        
        cell.journalTitle.text = "\(indexPath.row)"
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
}
