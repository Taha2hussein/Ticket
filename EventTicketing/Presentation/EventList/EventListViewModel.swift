//
//  EventListViewModel.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import Foundation
import UIKit


class EventListViewModel {
    private let fetchEventsUseCase: FetchEventsUseCaseProtocol
    private let seedEventsUseCase: SeedEventsUseCaseProtocol
    
    var events: [Event] = []
    var onEventsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var isLoading = false
    
    init(fetchEventsUseCase: FetchEventsUseCaseProtocol, seedEventsUseCase: SeedEventsUseCaseProtocol) {
        self.fetchEventsUseCase = fetchEventsUseCase
        self.seedEventsUseCase = seedEventsUseCase
    }
    
    func loadEvents() {
        guard !isLoading else {
            print("⏳ التحميل جاري بالفعل...")
            return
        }
        
        isLoading = true
        fetchEventsUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let events):
                    print("✅ تم تحميل \(events.count) حدث")
                    self?.events = events
                    self?.onEventsUpdated?()
                    
                case .failure(let error):
                    print("❌ خطأ: \(error.localizedDescription)")
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    func seedEvents() {
        seedEventsUseCase.execute { [weak self] result in
            switch result {
            case .success:
                print("✅ تم إضافة البيانات التجريبية")
                self?.loadEvents()
            case .failure(let error):
                print("❌ فشل إضافة البيانات: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.onError?("فشل إضافة البيانات التجريبية")
                }
            }
        }
    }
}

