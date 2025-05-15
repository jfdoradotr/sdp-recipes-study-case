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
  private let bookmarksStore: RecipesStoreProtocol
  var isFirstTime = true
  var selectedCuisine: Recipe.Cuisine? = nil
  var selectedDifficulty: Recipe.Difficulty? = nil
  var recipes: [Recipe] = []
  var bookmarkedIds: [String] = []

  var filteredRecipes: [Recipe] {
    recipes.filter { recipe in
      (selectedCuisine == nil || recipe.cuisine == selectedCuisine) &&
      (selectedDifficulty == nil || recipe.difficulty == selectedDifficulty)
    }
  }

  init(recipesService: RecipesRepositoryProtocol = LocalRecipesRepository(), bookmarksStore: RecipesStoreProtocol = RecipesStore()) {
    self.recipesService = recipesService
    self.bookmarksStore = bookmarksStore
    loadRecipes()
    loadBookmarks()
  }

  func loadRecipes () {
    if let recipes = try? recipesService.loadRecipes() {
      self.recipes = recipes
    } else {
      self.recipes = []
    }
  }

  func loadBookmarks() {
    bookmarkedIds = bookmarksStore.load()
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

  }
}
