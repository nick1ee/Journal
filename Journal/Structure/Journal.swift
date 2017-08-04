//
//  Journal.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import Foundation

struct Journal {

    var imageData: Data

    var title: String

    var content: String

    var timeStamp: String

}

extension Journal {

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

        guard let journal = object as? JournalModel else {

            throw FetchJournalError.invalidJournalObject

        }

        guard let data = journal.imageData else {

            throw FetchJournalError.missingImageData

        }

        self.imageData = data as Data

        guard let title = journal.title else {

            throw FetchJournalError.missingTitle

        }

        self.title = title

        guard let content = journal.content else {

            throw FetchJournalError.missingContent

        }

        self.content = content

        guard let timeStamp = journal.timeStamp else {

            throw FetchJournalError.missingTimeStamp

        }

        self.timeStamp = timeStamp

    }

}
