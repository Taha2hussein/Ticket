//
//  RemoteDataSource.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import ParseSwift
import UIKit
class RemoteEventDataSource {
    
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        let query = Event.query()
            .order([.descending("date")])
        
        query.find { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    completion(.success(events))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func seedEvents(completion: @escaping (Result<Bool, Error>) -> Void) {
        // Check if events already exist
        let query = Event.query().limit(1)
        
        query.find { result in
            switch result {
            case .success(let events):
                if !events.isEmpty {
                    print("⚠️ Events already exist")
                    completion(.success(false))
                    return
                }
                
                // Create sample events
                let sampleEvents = self.createSampleEvents()
                
                // Save events one by one using DispatchGroup
                let group = DispatchGroup()
                var errors: [Error] = []
                
                for event in sampleEvents {
                    group.enter()
                    
                    event.save { result in
                        switch result {
                        case .success(let savedEvent):
                            print("✅ Saved: \(savedEvent.title ?? "Unknown")")
                        case .failure(let error):
                            print("❌ Failed to save event: \(error)")
                            errors.append(error)
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    if errors.isEmpty {
                        print("✅ Successfully seeded \(sampleEvents.count) events")
                        completion(.success(true))
                    } else {
                        print("⚠️ Seeded with \(errors.count) errors")
                        completion(.failure(errors.first ?? NSError(domain: "SeedError", code: -1)))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createSampleEvents() -> [Event] {
        let dateFormatter = ISO8601DateFormatter()
        
        var event1 = Event()
        event1.title = "DXB BOAT PARTY"
        event1.date = dateFormatter.date(from: "2025-06-08T17:00:00Z")
        event1.location = "BAR BOAT\nKaraköy Pier, Kemankeş Karamustafa Paşa, Rıhtım Cd. No:13, 34425 Beyoğlu/İstanbul, Türkiye"
        event1.artistName = "Stephan Jolk"
        event1.eventDescription = "Entry is only allowed before 5:00 PM. 🍹\nYou must be +18 to attend. 🔞\nTickets are non-refundable and non-transferable after purchase. ❌\nIf you have any questions, contact the event host.\nLooking forward to seeing you there! 🎵🚤"
        event1.salesCountdown = 21
        event1.coverImageURL = "https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=1200"
        event1.organizer = "Dxb Events"
        event1.startTime = "17:00"
        event1.endTime = "22:00"
        event1.ageLimit = "18"
        event1.price = "900$"
        event1.des1 = "Hello"
        event1.des2 = "Hello2"
        event1.des3 = "Hello3"

        var event2 = Event()
        event2.title = "WAREHOUSE TECHNO NIGHT"
        event2.date = dateFormatter.date(from: "2025-12-22T22:00:00Z")
        event2.location = "Secret Warehouse\nAl Quoz Industrial Area 3, Dubai"
        event2.artistName = "Charlotte de Witte"
        event2.eventDescription = "Underground techno experience in a converted warehouse. Raw industrial vibes meet cutting-edge production. Location revealed 24 hours before event.\n\nDress Code: All Black\nAge: 21+\nNo refunds after purchase."
        event2.salesCountdown = 35
        event2.coverImageURL = "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=1200"
        event2.organizer = "Underground Collective"
        event2.startTime = "22:00"
        event2.endTime = "06:00"
        event2.ageLimit = "21"
        event2.price = "200$"
        event2.des1 = "Hello2"
        event2.des2 = "Hello25"
        event2.des3 = "Hello36"
        
        var event3 = Event()
        event3.title = "BEACH SUNSET SESSIONS"
        event3.date = dateFormatter.date(from: "2025-07-15T17:00:00Z")
        event3.location = "Kite Beach\nJumeirah Beach, Dubai"
        event3.artistName = "Âme (Live)"
        event3.eventDescription = "Melodic house and techno as the sun sets over the Arabian Gulf. Barefoot dancing on the sand.\n\nBring: Sunscreen, Good Vibes\nFamily-friendly until 21:00\nThen 21+ only"
        event3.salesCountdown = 8
        event3.coverImageURL = "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200"
        event3.organizer = "Beach Vibes DXB"
        event3.startTime = "17:00"
        event3.endTime = "23:00"
        event3.ageLimit = "All ages until 21:00"
        event3.price = "40$"
        event3.des1 = "Hello3"
        event3.des2 = "Hello23"
        event3.des3 = "Hello33"
        return [event1, event2, event3]
    }
}
