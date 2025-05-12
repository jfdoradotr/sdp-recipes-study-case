//
//  Recipe.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

struct RecipesResponse: Decodable {
  let recipes: [Recipe]
}

struct Recipe: Decodable {
  let id: Int
  let name: String
  let ingredients: [String]
  let instructtions: [String]
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
