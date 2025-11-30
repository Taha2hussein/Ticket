//
//  Event.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import Foundation
import ParseSwift
struct Event: ParseObject {
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    
    // Custom fields
    var title: String?
    var date: Date?
    var location: String?
    var artistName: String?
    var eventDescription: String?
    var coverImageURL: String?
    var salesCountdown: Int?
    var organizer: String?
    var startTime: String?
    var endTime: String?
    var ageLimit: String?
    var price: String?
    var des1: String?
    var des2: String?
    var des3: String?
}
