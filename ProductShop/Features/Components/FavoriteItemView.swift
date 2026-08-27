//
//  FavoriteItemView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteItemView: View {

    let product: Product
    let addToCart: () -> Void
    let removeFromFavorite: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            productImage
            productInfo

            Spacer()

            actions
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var productImage: some View {
        WebImage(url: URL(string: product.thumbnail)) { image in
            image
                .resizable()
        } placeholder: {
            Image("photo")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray.opacity(0.5))
                .padding(24)
        }
        .resizable()
        .scaledToFit()
        .frame(width: 90, height: 90)
        .background(.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
            
    }

    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(product.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.black)
                .lineLimit(2)

            Text(String(format: "$%.2f", product.price))
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primaryOrange)
        }
    }

    private var actions: some View {
        VStack {
            actionButton(
                icon: "heart.fill",
                background: .primaryOrange.opacity(0.1),
                foreground: .primaryOrange,
                action: removeFromFavorite
            )

            Spacer()

            actionButton(
                icon: "plus",
                background: .primaryOrange,
                foreground: .white,
                action: addToCart
            )
        }
    }

    private func actionButton(
        icon: String,
        background: Color,
        foreground: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .frame(width: 40, height: 40)
                .background(background)
                .foregroundStyle(foreground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
