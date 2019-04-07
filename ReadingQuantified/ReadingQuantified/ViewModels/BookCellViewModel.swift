//
//  BookCellViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/7/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import UIKit

struct BookCellViewModel {
    
    func formatDateString(from input: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withFractionalSeconds
        ]
        let date = inputFormatter.date(from: input)!
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .none
        outputFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        return outputFormatter.string(from: date)
    }
    
}
