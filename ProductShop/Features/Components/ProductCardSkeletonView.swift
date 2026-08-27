//
//  ProductCardSkeletonView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct ProductCardSkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.2))
                .frame(height: 140)

            RoundedRectangle(cornerRadius: 6)
                .fill(.gray.opacity(0.2))
                .frame(height: 16)

            RoundedRectangle(cornerRadius: 6)
                .fill(.gray.opacity(0.2))
                .frame(width: 80, height: 12)

            RoundedRectangle(cornerRadius: 6)
                .fill(.gray.opacity(0.2))
                .frame(width: 60, height: 18)
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .redacted(reason: .placeholder)
    }
}

#Preview {
    ProductCardSkeletonView()
}
