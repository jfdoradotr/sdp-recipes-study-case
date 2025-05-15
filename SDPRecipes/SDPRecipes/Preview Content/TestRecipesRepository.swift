//
//  TestRecipesRepository.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 14/05/25.
//

import Foundation

final class TestRecipesRepository: RecipesRepositoryProtocol {
  var url: URL {
    Bundle.main.url(forResource: "recipes_test", withExtension: "json")!
  }
}
