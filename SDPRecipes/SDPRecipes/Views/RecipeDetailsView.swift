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
        ZStack {
          AsyncImage(url: recipe.image) { phase in
            switch phase {
            case .empty:
              ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .success(let image):
              image
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(height: 250)
            case .failure(let error):
              Image(systemName: "photo.badge.exclamationmark.fill")
              .font(.largeTitle)
              .frame(maxWidth: .infinity)
            @unknown default:
              Image(systemName: "photo.badge.exclamationmark.fill")
              .font(.largeTitle)
              .frame(maxWidth: .infinity)            }
          }
        }

        .frame(height: 250)
      }
      .listRowBackground(Color.clear)
      .listRowInsets(EdgeInsets())

      Section {
        VStack(alignment: .leading, spacing: 12) {
          Text(recipe.name)
            .font(.title2)
            .fontWeight(.bold)
          VStack(alignment: .leading, spacing: 8) {
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
        ForEach(recipe.ingredients, id: \.self) { ingredient in
          HStack(alignment: .top) {
            Text("•")
              .font(.headline)
            Text(ingredient)
          }
          .listRowSeparator(.hidden)
        }
      } header: {
        Text("Ingredients")
      }

      Section {
        ForEach(recipe.instructions, id: \.self) { instruction in
          HStack(alignment: .top) {
            Text("•")
              .font(.headline)
            Text(instruction)
          }
          .listRowSeparator(.hidden)
        }
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
