//
//  SaveEventsUseCase.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import ParseSwift
class SeedEventsUseCase: SeedEventsUseCaseProtocol {
    private let repository: EventRepositoryProtocol
    
    init(repository: EventRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.seedEvents(completion: completion)
    }
}
