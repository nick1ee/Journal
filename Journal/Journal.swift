//
//  Journal.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import Foundation

struct Journal {
    
    var imageData: NSData
    
    var title: String
    
    var content: String
    
    var timeStamp: Int
    
}

extension Journal {
    
    typealias JournalObject = [String: Any]
    
    enum FetchJournalError: Error {
        
        case invalidJournalObject, missingImageData, missingTitle, missingContent, missingTimeStamp
    
    }
    
    struct Schema {
        
        static let imageData = "imageData"
        
        static let title = "title"
        
        static let content = "content"
        
        static let timeStamp = "timeStamp"
        
    }
    
    init(object: Any) throws {
        
        guard let journal = object as? JournalObject else {
            
            throw FetchJournalError.invalidJournalObject
            
        }
        
        guard let imageData = journal[Schema.imageData] as? NSData else {
            
            throw FetchJournalError.missingImageData
            
        }
        
        self.imageData = imageData
        
        guard let title = journal[Schema.title] as? String else {
            
            throw FetchJournalError.missingTitle
            
        }
        
        self.title = title
        
        guard let content = journal[Schema.content] as? String else {
            
            throw FetchJournalError.missingContent
            
        }
        
        self.content = content
        
        guard let timeStamp = journal[Schema.timeStamp] as? Int else {
            
            throw FetchJournalError.missingTimeStamp
            
        }
        
        self.timeStamp = timeStamp

    }
    
    func toDictionary() -> [String: Any] {
        
        let journalDictionary: [String: Any] = [Schema.imageData: self.imageData,
                                                
                                                Schema.title: self.title,
                                                
                                                Schema.content: self.content,
        
                                                Schema.timeStamp: self.timeStamp]
        
        return journalDictionary

    }
    
}
