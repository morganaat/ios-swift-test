//
//  Date+Extension.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation


extension Date {
    
    func formatTodaysDate() -> String {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM dd, YYYY"
        return dateFormat.string(from: Date())
    
    }
}
