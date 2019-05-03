//
//  YearSelectionViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/2/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class YearSelectionViewModel {
    
    // MARK: - Dependencies
    
    private let dashboardCoordinator: DashboardCoordinator
    
    init(dashboardCoordinator: DashboardCoordinator) {
        self.dashboardCoordinator = dashboardCoordinator
    }
    
    // MARK: - Properties
    
    var yearsRelay = BehaviorRelay<[String]>(value: [])
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func loadYears() {
        // TODO: Get this from the local repository
        let years = [
            "2019",
            "2018",
            "2017",
            "2016",
            "2015",
        ]
        
        yearsRelay.accept(years)
    }
    
    func updateYearSelected(_ year: String) {
        dashboardCoordinator.yearSelectedRelay.accept(year)
    }
}
