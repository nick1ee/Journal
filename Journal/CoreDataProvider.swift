//
//  CoreDataProvider.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import Foundation

class CoreDataProvider {
    
    var journals: [Journal] = []
    
    let context = AppDelegate.shared.persistentContainer.viewContext
    
    func fetchJournals() throws -> [Journal]? {
        
        var fetchedJournals: [Journal] = []
        
        do {
            
            let currentJournals = try context.fetch(JournalModel.fetchRequest())
            
            for object in currentJournals {
                
                do {
                    
                    let journal = try Journal.init(object: object)
                    
                    fetchedJournals.append(journal)
                    
                } catch let error {
                    
                    // TODO: Error handling
                    print(error.localizedDescription)
                    
                }
                
            }
            
            self.journals = fetchedJournals
            
            return self.journals
            
        } catch let error {
            
            // TODO: Error handling
            print(error.localizedDescription)
            
        }
        
        return []
        
    }
    
    func deleteJournal(withJournal journal: Journal) {
        
        self.journals = self.journals.filter({ $0.timeStamp != journal.timeStamp })
        
        do {
            
            let currentJournals = try context.fetch(JournalModel.fetchRequest())
            
            for object in currentJournals {
                
                guard let savedJournal = object as? JournalModel else { return }
                
                if savedJournal.timeStamp == journal.timeStamp {
                    
                    context.delete(savedJournal)
                    
                    AppDelegate.shared.saveContext()
                    
                }
                
            }
            
        } catch let error {
            
            // TODO: Error handlgin
            print(error.localizedDescription)
            
        }
        
    }
    
    func saveJournal(withJournal journal: Journal) {
        
        self.journals.append(journal)
        
        let savedJournal = JournalModel(context: context)
        
        savedJournal.timeStamp = journal.timeStamp
        
        savedJournal.title = journal.title
        
        savedJournal.content = journal.content
        
        savedJournal.imageData = journal.imageData as NSData
        
        AppDelegate.shared.saveContext()

    }
    
}
