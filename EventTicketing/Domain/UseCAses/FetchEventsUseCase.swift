//
//  FetchEventsUseCase.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import ParseSwift
protocol FetchEventsUseCaseProtocol {
    func execute(completion: @escaping (Result<[Event], Error>) -> Void)
}

protocol SeedEventsUseCaseProtocol {
    func execute(completion: @escaping (Result<Bool, Error>) -> Void)
}

class FetchEventsUseCase: FetchEventsUseCaseProtocol {
    private let repository: EventRepositoryProtocol
    
    init(repository: EventRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Event], Error>) -> Void) {
        repository.fetchEvents(completion: completion)
    }
}

