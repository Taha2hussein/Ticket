//
//  EventRepositoryImpl.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import ParseSwift
import UIKit
protocol EventRepositoryProtocol {
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void)
    func seedEvents(completion: @escaping (Result<Bool, Error>) -> Void)
}

class EventRepository: EventRepositoryProtocol {
    private let remoteDataSource: RemoteEventDataSource
    private let localDataSource: LocalEventDataSource
    
    init(remoteDataSource: RemoteEventDataSource, localDataSource: LocalEventDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        localDataSource.clearCache()
        // 1️⃣ شوف لو فيه كاش
        if let cachedEvents = localDataSource.getCachedEvents(), !cachedEvents.isEmpty {
          
            completion(.success(cachedEvents))
            return
        }
        
       
        remoteDataSource.fetchEvents { [weak self] result in
            switch result {
            case .success(let events):
             
                self?.localDataSource.cacheEvents(events)
                completion(.success(events))
                
            case .failure(let error):
                // مفيش نت ومفيش كاش = خطأ
                let noDataError = NSError(
                    domain: "EventRepository",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "لا يوجد اتصال بالإنترنت ولا توجد بيانات محفوظة"]
                )
                completion(.failure(noDataError))
            }
        }
    }
    
    func seedEvents(completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.seedEvents(completion: completion)
    }
}
