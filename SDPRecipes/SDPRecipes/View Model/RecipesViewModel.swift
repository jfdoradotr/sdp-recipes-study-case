//
//  RecipesViewModel.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

@Observable
final class RecipesViewModel {
  private let recipesService: RecipesRepositoryProtocol
  private let bookmarksStore: any StoreProtocol<Int>
  private let likesStore: any StoreProtocol<Int>

  var isFirstTime = true
  var selectedCuisine: Recipe.Cuisine? = nil
  var selectedDifficulty: Recipe.Difficulty? = nil
  var recipes: [Recipe] = []

  private var bookmarkIds: [Int] = []
  private var likesIds: [Int] = []

  var filteredRecipes: [Recipe] {
    recipes.filter { recipe in
      (selectedCuisine == nil || recipe.cuisine == selectedCuisine) &&
      (selectedDifficulty == nil || recipe.difficulty == selectedDifficulty)
    }
  }

  init(
    recipesService: RecipesRepositoryProtocol = LocalRecipesRepository(),
    bookmarksStore: any StoreProtocol<Int> = BookmarksRecipesStore(),
    likesStore: any StoreProtocol<Int> = LikesRecipesStore()
  ) {
    self.recipesService = recipesService
    self.bookmarksStore = bookmarksStore
    self.likesStore = likesStore
    loadRecipes()
    loadBookmarks()
    loadLikes()
  }

  func loadRecipes () {
    if let recipes = try? recipesService.loadRecipes() {
      self.recipes = recipes
    } else {
      self.recipes = []
    }
  }

  func selectCuisine(_ cuisine: Recipe.Cuisine) {
    if selectedCuisine == cuisine {
      selectedCuisine = nil
    } else {
      selectedCuisine = cuisine
    }
  }

  func selectDifficulty(_ difficulty: Recipe.Difficulty) {
    if selectedDifficulty == difficulty {
      selectedDifficulty = nil
    } else {
      selectedDifficulty = difficulty
    }
  }

  func bookmark(_ recipe: Recipe) {
    bookmarksStore.save(recipe.id)
    loadBookmarks()
  }

  func like(_ recipe: Recipe) {
    likesStore.save(recipe.id)
    loadLikes()
  }

  private func loadBookmarks() {
    bookmarkIds = bookmarksStore.load()
    bookmarkIds.forEach { id in
      if let index = recipes.firstIndex(where: { $0.id == id }) {
        recipes[index].isBookmarked = true
      }
    }
  }

  private func loadLikes() {
    likesIds = likesStore.load()
    likesIds.forEach { id in
      if let index = recipes.firstIndex(where: { $0.id == id }) {
        recipes[index].isFavorite = true
      }
    }
  }
}
