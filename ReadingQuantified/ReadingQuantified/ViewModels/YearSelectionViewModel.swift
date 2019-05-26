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
    
    var yearsRelay = BehaviorRelay<[Year]>(value: [])
    var years: [Year] = []
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func loadYears() {
        dashboardCoordinator.yearsRelay.asObservable()
            .subscribe(onNext: { [weak self] years in
                guard let strongSelf = self else { return }
                
                strongSelf.yearsRelay.accept(years)
                strongSelf.years = years
            })
            .disposed(by: bag)
        
        yearsRelay.accept(years)
    }
    
    func updateYearSelected(_ selectedYear: Year) {
        years = years.map { item in
            var newItem = item
            
            if item.value == selectedYear.value {
                newItem.isActive = true
            }
            else {
                newItem.isActive = false
            }
            
            return newItem
        }
        
        dashboardCoordinator.yearsRelay.accept(years)
        dashboardCoordinator.yearSelectedRelay.accept(selectedYear)
    }
}
