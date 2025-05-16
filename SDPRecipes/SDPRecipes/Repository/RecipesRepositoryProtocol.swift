//
//  RecipesRepositoryProtocol.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

protocol RecipesRepositoryProtocol {
  var url: URL { get }
}

extension RecipesRepositoryProtocol {
  func loadRecipes() throws(RecipeError) -> [Recipe] {
    guard let data = try? Data(contentsOf: url) else {
      throw .dataIsEmpty
    }

    let decoder = JSONDecoder()
    guard let response = try? decoder.decode(RecipesResponseDTO.self, from: data) else {
      throw .unableToParse
    }

    return response.recipes.map(\.recipe)
  }
}

enum RecipeError: Error {
  case dataIsEmpty
  case unableToParse
}

final class LocalRecipesRepository: RecipesRepositoryProtocol {
  var url: URL {
    Bundle.main.url(forResource: "recipes", withExtension: "json")!
  }
}
