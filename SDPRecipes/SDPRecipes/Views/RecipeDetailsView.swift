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
      coverSectionView
      basicInfoSectionView
      bulletedItemsSectionView(
        items: recipe.ingredients,
        header: "Ingredients"
      )
      bulletedItemsSectionView(
        items: recipe.instructions,
        header: "Instructions"
      )
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - Views

private extension RecipeDetailsView {
  var coverSectionView: some View {
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
          case .failure:
            Image(systemName: "photo.badge.exclamationmark.fill")
              .font(.largeTitle)
              .frame(maxWidth: .infinity)
          @unknown default:
            Image(systemName: "photo.badge.exclamationmark.fill")
              .font(.largeTitle)
              .frame(maxWidth: .infinity)
          }
        }
      }
      .frame(height: 250)
    }
    .listRowBackground(Color.clear)
    .listRowInsets(EdgeInsets())
  }

  var basicInfoSectionView: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(recipe.name)
          .font(.title2)
          .fontWeight(.bold)
        VStack(alignment: .leading, spacing: 8) {
          Text("⭐️ \(recipe.rating.formatted())")
          Text("🍽️ \(recipe.servings) people")
          Text("⏲️ \(recipe.prepTimeMinutes) min")
          Text("🔥 \(recipe.caloriesPerServing) cal/portion")
        }
      }
    } header: {
      Text("Basic Info")
    }
  }

  func bulletedItemsSectionView(items: [String], header: String) -> some View {
    Section {
      BulletedItemsView(items: items)
        .listRowSeparator(.hidden)
    } header: {
      Text(header)
    }
  }
}

// MARK: - BulletedItemsView

private extension RecipeDetailsView {
  struct BulletedItemsView: View {
    let items: [String]

    var body: some View {
      ForEach(items, id: \.self) { item in
        HStack(alignment: .top) {
          Text("•")
            .font(.headline)
          Text(item)
        }
      }
    }
  }
}

// MARK: - Preview

#Preview {
  RecipeDetailsView(recipe: .preview)
}
