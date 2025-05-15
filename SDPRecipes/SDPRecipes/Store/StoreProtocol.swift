//
//  RecipesStoreProtocol.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 15/05/25.
//

import Foundation

protocol StoreProtocol {
    func save(_ id: String)
    func load() -> [String]
}

class BaseStore: StoreProtocol {
    private let storeURL: URL
    private let storeName: String
    
    init(storeName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.storeName = storeName
        self.storeURL = documentsDirectory.appendingPathComponent("\(storeName).json")
    }
    
    func save(_ id: String) {
        var items = load()
        if !items.contains(id) {
            items.append(id)
            do {
                let data = try JSONEncoder().encode(items)
                try data.write(to: storeURL)
            } catch {
                print("Error saving \(storeName): \(error)")
            }
        }
    }
    
    func load() -> [String] {
        do {
            let data = try Data(contentsOf: storeURL)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            return []
        }
    }
}

final class BookmarksRecipesStore: BaseStore {
    init() {
        super.init(storeName: "bookmarks")
    }
}

final class LikesRecipesStore: BaseStore {
    init() {
        super.init(storeName: "likes")
    }
}
