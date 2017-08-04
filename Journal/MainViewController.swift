//
//  MainViewController.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var journals: [Journal] = []
    
    var index: Int?
    
    @IBOutlet weak var journalTableView: UITableView!
    
    @IBAction func btnCreateNewJournal(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addNewJournal", sender: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
        do {
            
            let fetchedJournals = try CoreDataProvider().fetchJournals()
            
            self.journals = fetchedJournals!
            
            journalTableView.reloadData()
            
        } catch let error {
            
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
        
        switch indexPath {
            
        case [0, 0]:
            
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        journalTableView.estimatedRowHeight = 250
        
        switch indexPath {
            
        case [0, 0]:
            
            return 50.0
            
        default:
            
            return UITableViewAutomaticDimension
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        self.performSegue(withIdentifier: "showJournalDetail", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        switch indexPath {
            
        case [0, 0]:
            
            return false
            
        default:
            
            return true
        }

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.journalTableView.beginUpdates()
            
            journalTableView.deleteRows(at: [indexPath], with: .left)
            
            CoreDataProvider().deleteJournal(withJournal: self.journals[indexPath.row])

            self.journals.remove(at: indexPath.row)
            
            self.journalTableView.endUpdates()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showJournalDetail" {
            
            let detailVC = segue.destination as! JournalViewController
            
            detailVC.receivedJournal = journals[index!]
            
        }
        
    }

}
