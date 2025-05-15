//
//  RecipesStoreProtocol.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 15/05/25.
//

import Foundation

protocol StoreProtocol<Element> where Element: Equatable & Codable {
  associatedtype Element
  func save(_ id: Element)
  func load() -> [Element]
}

class BaseStore<Element: Equatable & Codable>: StoreProtocol {
    private let storeURL: URL
    private let storeName: String
    
    init(storeName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.storeName = storeName
        self.storeURL = documentsDirectory.appendingPathComponent("\(storeName).json")
    }
    
    func save(_ id: Element) {
        var items = load()
        if !items.contains(where: { $0 == id }) {
            items.append(id)
            do {
                let data = try JSONEncoder().encode(items)
                try data.write(to: storeURL)
            } catch {
                print("Error saving \(storeName): \(error)")
            }
        }
    }
    
    func load() -> [Element] {
        do {
            let data = try Data(contentsOf: storeURL)
            return try JSONDecoder().decode([Element].self, from: data)
        } catch {
            return []
        }
    }
}

final class BookmarksRecipesStore: BaseStore<Int> {
    init() {
        super.init(storeName: "bookmarks")
    }
}

final class LikesRecipesStore: BaseStore<Int> {
    init() {
        super.init(storeName: "likes")
    }
}
