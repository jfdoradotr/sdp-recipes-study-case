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

final class BookmarksRecipesStore: StoreProtocol {
    private let bookmarksURL: URL
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        bookmarksURL = documentsDirectory.appendingPathComponent("bookmarks.json")
    }
    
    func save(_ id: String) {
        var bookmarks = load()
        if !bookmarks.contains(id) {
            bookmarks.append(id)
            do {
                let data = try JSONEncoder().encode(bookmarks)
                try data.write(to: bookmarksURL)
            } catch {
                print("Error saving bookmark: \(error)")
            }
        }
    }
    
    func load() -> [String] {
        do {
            let data = try Data(contentsOf: bookmarksURL)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            return []
        }
    }
}

final class LikesRecipesStore: StoreProtocol {
    private let likesURL: URL
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        likesURL = documentsDirectory.appendingPathComponent("likes.json")
    }
    
    func save(_ id: String) {
        var likes = load()
        if !likes.contains(id) {
            likes.append(id)
            do {
                let data = try JSONEncoder().encode(likes)
                try data.write(to: likesURL)
            } catch {
                print("Error saving like: \(error)")
            }
        }
    }
    
    func load() -> [String] {
        do {
            let data = try Data(contentsOf: likesURL)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            return []
        }
    }
}
