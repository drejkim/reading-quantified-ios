//
//  DashboardCoordinator.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/3/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class DashboardCoordinator {
    
    // TODO: Get this from the local repository
    var yearsRelay = BehaviorRelay<[Year]>(value:[
        Year(value: "2019", isActive: true),
        Year(value: "2018", isActive: false),
        Year(value: "2017", isActive: false),
        Year(value: "2016", isActive: false),
        Year(value: "2015", isActive: false)
    ])
    
    // Start with the current year
    var yearSelectedRelay = BehaviorRelay<Year>(value: Year(value: "2019", isActive: true))
    
}
