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
  var recipes: [Recipe] = []

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
}
