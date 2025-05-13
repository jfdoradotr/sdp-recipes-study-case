//
//  SDPRecipesApp.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 12/05/25.
//

import SwiftUI

@main
struct SDPRecipesApp: App {
  @State private var viewModel = RecipesViewModel(recipesService: RemoteRecipesLoader())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(viewModel)
    }
  }
}
