//
//  RecipeDetailsView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 14/05/25.
//

import SwiftUI

struct RecipeDetailsView: View {
  let recipe: Recipe

  var body: some View {
    Form {
      Section {
        AsyncImage(url: recipe.image) { image in
          image
            .resizable()
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(height: 250)
        } placeholder: {
          ProgressView()
            .controlSize(.extraLarge)
        }
      }
      .listRowBackground(Color.clear)
      .listRowInsets(EdgeInsets())

      Section {
        VStack(alignment: .leading, spacing: 12) {
          Text(recipe.name)
            .font(.title2)
            .fontWeight(.bold)
          VStack(alignment: .leading) {
            Text("⭐️ \(recipe.rating.formatted())")
            Text("🍽️ \(recipe.servings) people")
            Text("⏲️ \(recipe.prepTimeMinutes) min")
            Text("⏲️ \(recipe.caloriesPerServing) cal/portion")
          }
        }
      } header: {
        Text("Basic Info")
      }

      Section {
        Text(recipe.ingredients.map( { "• \($0)" } ).joined(separator: "\n"))
      } header: {
        Text("Ingredients")
      }

      Section {
        Text(recipe.instructions.map( { "• \($0)" } ).joined(separator: "\n"))
      } header: {
        Text("Instructions")
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  RecipeDetailsView(recipe: .preview)
}
