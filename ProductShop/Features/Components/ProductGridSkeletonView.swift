//
//  ProductGridSkeletonView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct ProductGridSkeletonView: View {

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(0..<6, id: \.self) { _ in
                ProductCardSkeletonView()
            }
        }
    }
}

#Preview {
    ProductGridSkeletonView()
}
