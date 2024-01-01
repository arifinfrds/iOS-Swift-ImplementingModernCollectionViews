//
//  MenuListView.swift
//  ImplementingModernCollectionViews
//
//  Created by arifin on 01/01/24.
//

import SwiftUI

enum OptionType: String {
    case singleList = "Single list"
    case singleListPortraitTwoGridsLandscape = "Single list portrait, two grids landscape"
}

struct MenuListView: View {
    
    private let options: [OptionType] = [
        .singleList,
        .singleListPortraitTwoGridsLandscape
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
        case .singleListPortraitTwoGridsLandscape:
            SingleListPortraitTwoGridsLandscapeView()
        }
    }
}

#Preview {
    NavigationView {
        MenuListView()
    }
}
