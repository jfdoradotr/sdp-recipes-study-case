//
//  ContentView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import SwiftUI

struct ContentView: View {
  @Environment(RecipesViewModel.self) var viewModel

  @State private var isFirstTime = true

  var body: some View {
    TabView {
      Tab("Recipes", systemImage: "fork.knife") {
        NavigationStack {
          Text("Hey oh!")
            .navigationTitle("Recipes")
        }
      }
      Tab("Saved", systemImage: "bookmark.fill") {
        NavigationStack {
          Text("Hey oh!")
            .navigationTitle("Saved")
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
    .fullScreenCover(isPresented: $isFirstTime) {
      WelcomeView(isFirstTime: $isFirstTime)
    }
  }
}

#Preview {
  ContentView()
    .environment(RecipesViewModel(recipesService: LocalRecipesLoader()))
}
