//
//  RecipesListView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 14/05/25.
//

import SwiftUI

struct RecipesListView: View {
  @Environment(RecipesViewModel.self) var recipesModel

  var body: some View {
    List(recipesModel.recipes) { recipe in
      Text(recipe.name)
    }
  }
}

#Preview {
  RecipesListView()
    .environment(RecipesViewModel(recipesService: TestRecipesLoader()))
}
