//
//  MenuListView.swift
//  ImplementingModernCollectionViews
//
//  Created by arifin on 01/01/24.
//

import SwiftUI

enum OptionType: String {
    case singleList = "Single list"
    case singleListPortraitTwoGridsOnHorizontal = "Single list portrait, two grids on horiziontal"
}

struct MenuListView: View {
    
    private let options: [OptionType] = [
        .singleList,
        .singleListPortraitTwoGridsOnHorizontal
    ]
    
    var body: some View {
        NavigationStack {
            List(options, id: \.self) { optionType in
                NavigationLink {
                    detailView(from: optionType)
                } label: {
                    Text(optionType.rawValue)
                }
                
            }
        }
        .navigationTitle("Modern List")
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    private func detailView(from optionType: OptionType) -> some View {
        switch optionType {
        case .singleList:
            List2ViewPreview()
        case .singleListPortraitTwoGridsOnHorizontal:
            CollectionViewPreview()
        }
    }
}

#Preview {
    NavigationView {
        MenuListView()
    }
}
