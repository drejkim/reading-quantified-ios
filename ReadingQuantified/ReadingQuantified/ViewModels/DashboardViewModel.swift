//
//  DashboardViewModel.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 5/1/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class DashboardViewModel {
    
    // MARK: - Properties
    
    var metricsRelay = BehaviorRelay<[Metric]>(value: [])
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func loadMetrics() {
        // TODO: Update with real data
        let metrics = [
            Metric(title: "Books Finished", caption: nil, value: "7"),
            Metric(title: "Avg. Days to Finish", caption: nil, value: "13.1"),
            Metric(title: "The Problem of Pain", caption: "Shortest Read", value: "7"),
            Metric(title: "Tools of Titans", caption: "Longest Read", value: "23")
        ]
        
        metricsRelay.accept(metrics)
    }
}
