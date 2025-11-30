//
//  LocalDataSource.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import ParseSwift
import UIKit
class LocalEventDataSource {
    private let fileName = "cachedEvents.json"
    private let fileManager = FileManager.default
    
    // مسار الملف في Documents Directory
    private var fileURL: URL? {
        guard let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsPath.appendingPathComponent(fileName)
    }
    
    func cacheEvents(_ events: [Event]) {
        guard let fileURL = fileURL else {
            print("❌ لا يمكن الوصول إلى مسار الملف")
            return
        }
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(events)
            try data.write(to: fileURL, options: .atomic)
            print("💾 تم حفظ \(events.count) حدث في الملف")
        } catch {
            print("❌ خطأ في حفظ الكاش: \(error.localizedDescription)")
        }
    }
    
    func getCachedEvents() -> [Event]? {
        guard let fileURL = fileURL else {
            print("❌ لا يمكن الوصول إلى مسار الملف")
            return nil
        }
        
        // تحقق من وجود الملف
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("📭 لا يوجد كاش محفوظ")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let events = try decoder.decode([Event].self, from: data)
            print("📦 تم تحميل \(events.count) حدث من الكاش")
            return events
        } catch {
            print("❌ خطأ في قراءة الكاش: \(error.localizedDescription)")
            return nil
        }
    }
    
    func clearCache() {
        guard let fileURL = fileURL else { return }
        
        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
                print("🗑️ تم مسح الكاش")
            }
        } catch {
            print("❌ خطأ في مسح الكاش: \(error.localizedDescription)")
        }
    }
    
    // دالة إضافية: التحقق من حجم الكاش
    func getCacheSize() -> String {
        guard let fileURL = fileURL,
              fileManager.fileExists(atPath: fileURL.path),
              let attributes = try? fileManager.attributesOfItem(atPath: fileURL.path),
              let fileSize = attributes[.size] as? Int64 else {
            return "0 KB"
        }
        
        let sizeInKB = Double(fileSize) / 1024.0
        return String(format: "%.2f KB", sizeInKB)
    }
}
