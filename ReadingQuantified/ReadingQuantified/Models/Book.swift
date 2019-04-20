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
    
    @objc dynamic var url = ""
    let genres = List<String>()
    @objc dynamic var created_at = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var title = ""
    @objc dynamic var trello_id = ""
    @objc dynamic var date_started = ""
    @objc dynamic var date_finished = ""
    
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
}
