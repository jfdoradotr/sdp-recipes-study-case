//
//  BookmarksListView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 20/05/25.
//

import SwiftUI

struct BookmarksListView: View {
  @Environment(RecipesViewModel.self) private var recipesModel

  var body: some View {
    List(recipesModel.bookmarkedRecipes) { recipe in
      NavigationLink(value: recipe) {
        Text(recipe.name)
      }
    }
    .listStyle(.plain)
    .navigationTitle("Saved")
    .navigationDestination(for: Recipe.self) { recipe in
      RecipeDetailsView(recipe: recipe)
    }
  }
}

#Preview {
  NavigationStack {
    BookmarksListView()
  }
  .environment(
    RecipesViewModel(
      recipesService: TestRecipesRepository(),
      bookmarksStore: BookmarksRecipesStore(),
      likesStore: LikesRecipesStore()
    )
  )
}
