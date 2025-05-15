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
  var isFirstTime = true
  var selectedCuisine: Recipe.Cuisine? = nil
  var selectedDifficulty: Recipe.Difficulty? = nil
  var recipes: [Recipe] = []

  var filteredRecipes: [Recipe] {
    recipes
      .filter { recipe in
        guard let selectedCuisine else { return true }
        return recipe.cuisine == selectedCuisine
      }
      .filter { recipe in
        guard let selectedDifficulty else { return true }
        return recipe.difficulty == selectedDifficulty
      }
  }

  init(recipesService: RecipesRepositoryProtocol = LocalRecipesRepository()) {
    self.recipesService = recipesService
    loadRecipes()
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
}
