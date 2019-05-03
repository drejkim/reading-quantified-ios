//
//  Book.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 4/6/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Realm
import RealmSwift

class Book: Object, Decodable {
    
    // MARK: - Variables
    
    // Decoded variables
    
    @objc dynamic var url = ""
    let genres = List<String>()
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var title = ""
    @objc dynamic var trello_id = ""
    @objc dynamic var date_started = ""
    @objc dynamic var date_finished = ""
    
    // Computed variables
    
    @objc dynamic var days_to_finish = 0
    
    override static func primaryKey() -> String? {
        return "trello_id"
    }
    
    enum CodingKeys: String, CodingKey {
        case url
        case genres
        case created_at
        case updated_at
        case title
        case trello_id
        case date_started
        case date_finished
    }
    
    // MARK: - Decodable initializers
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try container.decode(String.self, forKey: .url)
        created_at = try container.decode(String.self, forKey: .created_at)
        updated_at = try container.decode(String.self, forKey: .updated_at)
        title = try container.decode(String.self, forKey: .title)
        trello_id = try container.decode(String.self, forKey: .trello_id)
        date_started = try container.decode(String.self, forKey: .date_started)
        date_finished = try container.decode(String.self, forKey: .date_finished)
        
        let genresArray = try container.decode([String].self, forKey: .genres)
        genres.append(objectsIn: genresArray)
        
        super.init()
        
        days_to_finish = calculateDaysToFinish()
    }
    
    // MARK: - Object initializers
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    // MARK: - Private Functions
    
    private func calculateDaysToFinish() -> Int {
        let startDate = getDate(from: date_started)
        let finishedDate = getDate(from: date_finished)
        let components = Calendar.current.dateComponents([.day], from: startDate, to: finishedDate)
        
        return components.day!
    }
    
    private func getDate(from string: String) -> Date {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withFractionalSeconds
        ]
        
        return inputFormatter.date(from: string)!
    }
}
