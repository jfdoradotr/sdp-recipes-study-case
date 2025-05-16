//
//  RecipeDTO.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 16/05/25.
//

import Foundation

struct RecipesResponseDTO: Decodable {
  let recipes: [RecipeDTO]
  let total: Int
  let skip: Int
  let limit: Int
}

struct RecipeDTO: Decodable {
  let id: Int
  let name: String
  let ingredients: [String]
  let instructions: [String]
  let prepTimeMinutes: Int
  let cookTimeMinutes: Int
  let servings: Int
  let difficulty: String
  let cuisine: String
  let caloriesPerServing: Int
  let tags: [String]
  let userId: Int
  let image: URL
  let rating: Double
  let reviewCount: Int
  let mealType: [String]
}
