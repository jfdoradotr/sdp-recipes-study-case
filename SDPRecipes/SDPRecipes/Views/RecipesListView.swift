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
    @Bindable var bindableRecipesModel = recipesModel
    VStack(spacing: 12) {
      HorizontalFilterChipsView(
        items: Recipe.Cuisine.allCases,
        selected: $bindableRecipesModel.selectedCuisine,
        allOptionText: "🌎 All",
        onSelect: { item in
          recipesModel.selectCuisine(item)
        }
      )
      .frame(height: 40)

      HorizontalFilterChipsView(
        items: Recipe.Difficulty.allCases,
        selected: $bindableRecipesModel.selectedDifficulty,
        allOptionText: "🧑‍🍳 All",
        onSelect: { item in
          recipesModel.selectDifficulty(item)
        }
      )
      .frame(height: 40)
      List(recipesModel.filteredRecipes) { recipe in
        NavigationLink(value: recipe) {
          Cell(recipe: recipe)
        }
      }
      .listStyle(.plain)
    }
    .navigationTitle("Recipes")
    .navigationDestination(for: Recipe.self) { recipe in
      RecipeDetailsView(recipe: recipe)
    }
  }
}

struct ChipButtonStyle: ButtonStyle {
  var isSelected: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.subheadline)
      .fontWeight(.bold)
      .foregroundStyle(isSelected ? Color.blue : Color.black)
      .padding(.vertical, 5)
      .padding(.horizontal, 8)
      .frame(minWidth: 100)
      .background {
        Capsule(style: .continuous)
          .fill(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
      }
  }
}

private extension RecipesListView {
  struct Cell: View {
    let recipe: Recipe

    var body: some View {
      HStack(alignment: .top, spacing: 8) {
        AsyncImage(url: recipe.image) { image in
          image
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
          ProgressView()
        }
        .frame(width: 60, height: 60)

        VStack(alignment: .leading, spacing: 8) {
          Text(recipe.name)
            .font(.headline)
          HStack(spacing: 8) {
            Text("⏲️ \(recipe.prepTimeMinutes) min")
            Text("|")
            Text("🍽️ \(recipe.servings) portions")
          }
          .font(.footnote)
          .foregroundStyle(.secondary)
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    RecipesListView()
  }
  .environment(RecipesViewModel(recipesService: TestRecipesRepository()))
}

#Preview("Cell") {
  RecipesListView.Cell(recipe: .preview)
}
