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
  var recipes: [Recipe] = []

  var filteredRecipes: [Recipe] {
    guard let selectedCuisine else {
      return recipes
    }

    return recipes.filter { $0.cuisine == selectedCuisine }
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
}
