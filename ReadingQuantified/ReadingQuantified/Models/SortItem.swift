//
//  SortItem.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/18/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

struct SortItem {
    
    enum SortDirection {
        case ascending, descending
    }
    
    let label: String
    var direction: SortDirection
    var isActive: Bool
}
