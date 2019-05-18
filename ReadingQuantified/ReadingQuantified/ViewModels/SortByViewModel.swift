//
//  SortByViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/18/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class SortByViewModel {
    
    // MARK: - Dependencies
    
    private let coordinator: SortByCoordinator
    
    init(coordinator: SortByCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Properties
    
    var sortItemsRelay = BehaviorRelay<[SortItem]>(value: [])
    var sortItems: [SortItem] = []
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func loadSortItems() {
        coordinator.sortItemsRelay.asObservable()
            .subscribe(onNext: { [weak self] items in
                guard let strongSelf = self else { return }
                
                strongSelf.sortItemsRelay.accept(items)
                strongSelf.sortItems = items
            })
            .disposed(by: bag)
    }
    
    func updateActiveSortItem(_ activeItem: SortItem) {
        sortItems = sortItems.map { item in
            var newItem = item
            
            if item.label == activeItem.label {
                let newDirection: SortItem.SortDirection = item.direction == .ascending ? .descending : .ascending
                
                newItem.direction = item.isActive ? newDirection : item.direction
                newItem.isActive = true
            }
            else {
                newItem.isActive = false
            }
            
            return newItem
        }
        
        coordinator.sortItemsRelay.accept(sortItems)
    }
    
}
