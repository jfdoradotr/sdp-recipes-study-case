//
//  RecipeDTO 2.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
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
