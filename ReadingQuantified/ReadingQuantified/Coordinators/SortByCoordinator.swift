//
//  SortByCoordinator.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/18/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class SortByCoordinator {
    
    var sortItemsRelay = BehaviorRelay<[SortItem]>(value: [
        SortItem(label: "Title", direction: .ascending, isActive: false),
        SortItem(label: "Date Started", direction: .descending, isActive: false),
        SortItem(label: "Date Finished", direction: .descending, isActive: true)
    ])
    
}
