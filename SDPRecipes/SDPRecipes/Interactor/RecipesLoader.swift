//
//  RecipesLoader.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

protocol RecipesLoader {
  func loadRecipes() throws(RecipeError) -> [Recipe]
}

enum RecipeError: Error {
  case dataIsEmpty
  case unableToParse
}

final class LocalRecipesLoader: RecipesLoader {
  func loadRecipes() throws(RecipeError) -> [Recipe] {
    guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
      fatalError("File not found")
    }

    guard let data = try? Data(contentsOf: url) else {
      throw .dataIsEmpty
    }

    let decoder = JSONDecoder()
    guard let recipesResponseDTO = try? decoder.decode(RecipesResponseDTO.self, from: data) else {
      throw .unableToParse
    }

    return RecipesMapper.map(recipesResponseDTO)
  }
}

private struct RecipesMapper {
  static func map(_ recipesResponseDTO: RecipesResponseDTO) -> [Recipe] {
    recipesResponseDTO.recipes.compactMap { dtoItem in
      Recipe(
        id: dtoItem.id,
        name: dtoItem.name,
        ingredients: dtoItem.ingredients,
        instructions: dtoItem.instructions,
        prepTimeMinutes: dtoItem.prepTimeMinutes,
        cookTimeMinutes: dtoItem.cookTimeMinutes,
        servings: dtoItem.servings,
        difficulty: dtoItem.difficulty,
        cuisine: dtoItem.cuisine,
        caloriesPerServing: dtoItem.caloriesPerServing,
        tags: dtoItem.tags,
        userId: dtoItem.userId,
        image: dtoItem.image,
        rating: dtoItem.rating,
        reviewCount: dtoItem.reviewCount,
        mealType: dtoItem.mealType
      )
    }
  }
}
