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
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch journals.count {
            
        case 0:
            
            return 1
            
        default:
            
            return journals.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch journals.count {
            
        case 0:
            
            let cell = UITableViewCell()
            
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalTableViewCell
            
            cell.journalTitle.text = journals[indexPath.row].title
            
            // MARK: Decode image
            
            let data = journals[indexPath.row].imageData
            
            cell.journalImageView.image = UIImage(data: data as Data)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let screen = UIScreen.main.bounds
            
            let slate = UIColor.init(red: 67/255, green: 86/255, blue: 97/255, alpha: 1)
            
            let dustyOrange = UIColor.init(red: 237/255, green: 96/255, blue: 81/255, alpha: 1)
            
            let header = UIView(frame: CGRect(x: 0, y: 0, width: screen.width, height: 50))
            
            let journalLabel = UILabel(frame: CGRect(x: 25, y: 5, width: 150, height: 40))
            
            let title = NSAttributedString(string: "My Journals", attributes: [NSForegroundColorAttributeName: slate])
            
            journalLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
            
            journalLabel.attributedText = title
            
            let addButton = UIButton(frame: CGRect(x: screen.width - 60, y: 3, width: 44, height: 44))
            
            addButton.setImage(UIImage(named: "icon_plus"), for: .normal)
            
            addButton.tintColor = dustyOrange
            
            addButton.addTarget(self, action: #selector(self.addJournal), for: UIControlEvents.touchDown)
            
            header.addSubview(journalLabel)
            
            header.addSubview(addButton)
            
            return header
            
        }
        
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showJournalDetail", sender: nil)
        
    }
    
    func addJournal() {
        
        performSegue(withIdentifier: "addNewJournal", sender: nil)
        
    }
    
    
    
}
