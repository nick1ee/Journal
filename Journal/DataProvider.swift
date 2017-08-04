//
//  DataProvider.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import Foundation

class DataProvider {
    
//    let userDefault = UserDefaults.standard
    
    var journals: [Journal] = []
    
    func fetchJournals() -> [Journal] {
        
//        guard let fetehedJournals = userDefault.value(forKey: "Journal") as? [Journal] else {
//        
//            return []
//        
//        }
//        
//        self.journals = fetehedJournals
//        
//        return self.journals
        
    }
    
    func updataJournals(withJournal journal: Journal) {
        
//        var updatedJournals = journals.filter({ $0.timeStamp != journal.timeStamp })
//        
//        updatedJournals.append(journal)
//        
//        userDefault.set(updatedJournals, forKey: "Journal")
//        
//        userDefault.synchronize()
//        
//        self.journals = updatedJournals
//        
    }
    
}
