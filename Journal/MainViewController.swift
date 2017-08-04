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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
        do {
            
            let fetchedJournals = try CoreDataProvider().fetchJournals()
            
            self.journals = fetchedJournals!
            
            journalTableView.reloadData()
            
        } catch let error {
            
            // TODO: Error handling
            print(error.localizedDescription)
            
        }
        
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            
            return 1
            
        default:
            
            return journals.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = journalTableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleTableViewCell
            
            return cell
            
        default:
            
            let cell = journalTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalTableViewCell
            
            cell.journalTitle.text = journals[indexPath.row].title
            
            // MARK: Decode image
            
            let data = journals[indexPath.row].imageData
            
            cell.journalImageView.image = UIImage(data: data as Data)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showJournalDetail", sender: nil)
        
    }
    
    func addJournal() {
        
        performSegue(withIdentifier: "addNewJournal", sender: nil)
        
    }
    
    
    
}
