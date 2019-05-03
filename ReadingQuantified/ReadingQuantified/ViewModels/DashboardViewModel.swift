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
    
    // MARK: - Dependencies
    
    private let dashboardCoordinator: DashboardCoordinator
    
    init(dashboardCoordinator: DashboardCoordinator) {
        self.dashboardCoordinator = dashboardCoordinator
    }
    
    // MARK: - Properties
    
    var metricsRelay = BehaviorRelay<[Metric]>(value: [])
    var yearSelectedRelay = BehaviorRelay<String>(value: "")
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    private let localBooksRepository = LocalBooksRepository()
    
    private var books: [Book] = []
    
    // MARK: - Functions
    
    func loadMetrics(by year: String) {
        filterBooks(by: year, sortedBy: "days_to_finish")
        
        var metrics: [Metric] = []
        metrics.append(Metric(title: "Books Finished", caption: nil, value: String(books.count)))
        
        guard
            let avgDaysToFinish = getAvgDaysToFinish(by: year),
            let shortestBook = getShortestRead(by: year),
            let longestBook = getLongestRead(by: year) else { return }
        
        metrics.append(Metric(title: "Avg. Days to Finish", caption: nil, value: String(format: "%.1f", avgDaysToFinish)))
        metrics.append(Metric(title: shortestBook.title, caption: "Shortest read in days", value: String(shortestBook.days_to_finish)))
        metrics.append(Metric(title: longestBook.title, caption: "Longest read in days", value: String(longestBook.days_to_finish)))
        
        metricsRelay.accept(metrics)
    }
    
    func loadYearSelected() {
        dashboardCoordinator.yearSelectedRelay.asObservable()
            .subscribe(onNext: { [weak self] year in
                guard let strongSelf = self else { return }
                
                strongSelf.yearSelectedRelay.accept(year)
            })
            .disposed(by: bag)
    }
    
    // MARK: - Private Functions
    
    private func filterBooks(by year: String, sortedBy key: String) {
        localBooksRepository.filter(by: year, sortedBy: key)
            .subscribe(onNext: { [weak self] books in
                guard let strongSelf = self else { return }
                
                strongSelf.books = books
            })
            .disposed(by: bag)
    }
    
    private func getShortestRead(by year: String) -> Book? {
        return localBooksRepository.getShortestRead(filteredBy: year)
    }
    
    private func getLongestRead(by year: String) -> Book? {
        return localBooksRepository.getLongestRead(filteredBy: year)
    }
    
    private func getAvgDaysToFinish(by year: String) -> Float? {
        return localBooksRepository.getAvgDaysToFinish(filteredBy: year)
    }
}
