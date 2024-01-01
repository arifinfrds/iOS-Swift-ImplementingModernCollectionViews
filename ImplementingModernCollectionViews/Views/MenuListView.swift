//
//  MenuListView.swift
//  ImplementingModernCollectionViews
//
//  Created by arifin on 01/01/24.
//

import SwiftUI

enum OptionType: String {
    case singleList = "Single list"
    case singleListPortraitTwoGridsHorizontal = "Single list portrait, two grids horiziontal"
}

struct MenuListView: View {
    
    private let options: [OptionType] = [
        .singleList,
        .singleListPortraitTwoGridsHorizontal
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
            SingleListView()
        case .singleListPortraitTwoGridsHorizontal:
            SingleListPortraitTwoGridsHorizontalView()
        }
    }
}

#Preview {
    NavigationView {
        MenuListView()
    }
}
