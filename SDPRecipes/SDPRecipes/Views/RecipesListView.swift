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
    VStack {
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(Recipe.Cuisine.allCases) { cuisine in
            Button(cuisine.iconableValue) {
              recipesModel.selectCuisine(cuisine)
            }
            .buttonStyle(ChipButtonStyle(isSelected: recipesModel.selectedCuisine == cuisine))
          }
        }
        .safeAreaPadding()
      }
      .scrollIndicators(.hidden)
      .frame(height: 80)
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
