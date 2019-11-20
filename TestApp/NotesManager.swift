//
//  NotesManager.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

class NotesManager {
    
    public typealias SuccessHandler = ([Note]) -> Void
    public typealias ErrorHandler = (String) -> Void
    
    class func getNotes(completionSuccess: SuccessHandler? = nil, completionError: ErrorHandler? = nil ) {
        
        let notes = SampleNotes.notes
        if notes.count == 0 || notes.isEmpty {
            if let completion = completionError {
                //TODO: properly handle errors
                completion("Array is empty")
            }
        } else {
            if let completion = completionSuccess {
                completion(notes)
            }
        }
    }
}
