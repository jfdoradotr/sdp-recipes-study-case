//
//  ContentView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import SwiftUI

struct ContentView: View {
  @Environment(RecipesViewModel.self) var viewModel

  var body: some View {
    @Bindable var bindableViewModel = viewModel

    TabView {
      Tab("Recipes", systemImage: "fork.knife") {
        NavigationStack {
          RecipesListView()
        }
      }
      Tab("Saved", systemImage: "bookmark.fill") {
        NavigationStack {
          BookmarksListView()
        }
      }
      Tab("Shopping List", systemImage: "cart.fill") {
        NavigationStack {
          Text("Hey oh!")
            .navigationTitle("Shopping List")
        }
      }
      Tab("Timer", systemImage: "timer") {
        NavigationStack {
          Text("Hey oh!")
            .navigationTitle("Timer")
        }
      }
    }
    .fullScreenCover(isPresented: $bindableViewModel.isFirstTime) {
      WelcomeView(isFirstTime: $bindableViewModel.isFirstTime)
    }
  }
}

#Preview {
  ContentView()
    .environment(RecipesViewModel(recipesService: LocalRecipesRepository()))
}
