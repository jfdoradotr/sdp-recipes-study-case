//
//  RecipesViewModel.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

@Observable
final class RecipesViewModel {
  private let recipesService: RecipesFeature
  var recipes: [Recipe] = []

  init(recipesService: RecipesFeature) {
    self.recipesService = recipesService
    loadRecipes()
  }

  func loadRecipes () {
    if let recipes = try? recipesService.fetchRecipes() {
      self.recipes = recipes
    } else {
      self.recipes = []
    }
  }
}
