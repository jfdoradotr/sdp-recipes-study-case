//
//  HorizontalFilterChipsView.swift
//  SDPRecipes
//
//  Created by Juan Francisco Dorado Torres on 15/05/25.
//

import SwiftUI

protocol FilterProtocol: Identifiable, Equatable {
  var displayText: String { get }
}

struct HorizontalFilterChipsView<Item: FilterProtocol>: View {
  let items: [Item]
  @Binding var selected: Item?
  var hasAllOption: Bool = false
  var onSelect: (Item) -> Void

  var body: some View {
    ScrollView(.horizontal) {
      LazyHStack {
        Button("🌎 All") {
          selected = nil
        }
        .buttonStyle(ChipButtonStyle(isSelected: selected == nil))
        ForEach(items) { item in
          Button(item.displayText) {
            onSelect(item)
          }
          .buttonStyle(ChipButtonStyle(isSelected: selected == item))
        }
      }
      .safeAreaPadding()
    }
    .scrollIndicators(.hidden)
  }
}

#Preview {
  enum Options: String, CaseIterable, FilterProtocol {
    var displayText: String { rawValue }

    var id: Self { self }

    case all
    case vegetarian
    case vegan
    case glutenFree
  }

  return HorizontalFilterChipsView(
    items: Options.allCases,
    selected: .constant(Options.all),
    onSelect: { _ in }
  )
}
