//
//  RecipeDTO 2.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import Foundation

struct RecipesResponse: Decodable {
  let recipes: [Recipe]
  let total: Int
  let skip: Int
  let limit: Int
}

struct Recipe: Decodable, Identifiable, Hashable {
  let id: Int
  let name: String
  let ingredients: [String]
  let instructions: [String]
  let prepTimeMinutes: Int
  let cookTimeMinutes: Int
  let servings: Int
  let difficulty: Difficulty
  let cuisine: Cuisine
  let caloriesPerServing: Int
  let tags: [String]
  let userId: Int
  let image: URL
  let rating: Double
  let reviewCount: Int
  let mealType: [String]
}

extension Recipe {
  enum Difficulty: String, CaseIterable, Decodable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
  }
}

extension Recipe {
  enum Cuisine: String, CaseIterable, Decodable, Identifiable {
    case american = "American"
    case asian = "Asian"
    case brazilian = "Brazilian"
    case greek = "Greek"
    case indian = "Indian"
    case italian = "Italian"
    case japanese = "Japanese"
    case korean = "Korean"
    case lebanese = "Lebanese"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case moroccan = "Moroccan"
    case pakistani = "Pakistani"
    case russian = "Russian"
    case smoothie = "Smoothie"
    case thai = "Thai"
    case turkish = "Turkish"

    var id: Self { self }

    var iconableValue: String {
      var iconText = switch self {
      case .american:
        "🇺🇸"
      case .asian:
        "🌏"
      case .brazilian:
        "🇧🇷"
      case .greek:
        "🇬🇷"
      case .indian:
        "🇮🇳"
      case .italian:
        "🇮🇹"
      case .japanese:
        "🇯🇵"
      case .korean:
        "🇰🇷"
      case .lebanese:
        "🇱🇧"
      case .mediterranean:
        "🌊"
      case .mexican:
        "🇲🇽"
      case .moroccan:
        "🇲🇦"
      case .pakistani:
        "🇵🇰"
      case .russian:
        "🇷🇺"
      case .smoothie:
        "🥤"
      case .thai:
        "🇹🇭"
      case .turkish:
        "🇹🇷"
      }
      return "\(iconText) \(rawValue)"
    }
  }
}
