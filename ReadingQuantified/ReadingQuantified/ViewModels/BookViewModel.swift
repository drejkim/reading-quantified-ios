//
//  BookViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/13/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

struct BookViewModel {
    
    var book: Book?
    
    func formatDateString(from input: String, to dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withFractionalSeconds
        ]
        let date = inputFormatter.date(from: input)!
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.dateStyle = dateStyle
        outputFormatter.timeStyle = timeStyle
        outputFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        return outputFormatter.string(from: date)
    }
    
    func formatDateString(from input: String, to dateFormat: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withFractionalSeconds
        ]
        let date = inputFormatter.date(from: input)!
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.dateFormat = dateFormat
        outputFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        return outputFormatter.string(from: date)
    }
}
