//
//  CartItemView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemView: View {

    let item: CartItem
    let increaseAction: () -> Void
    let decreaseAction: () -> Void
    let removeAction: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            productImage
            productInfo
            Spacer()
            removeButton
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private extension CartItemView {

    var productImage: some View {
//        NavigationLink {
//            ProductsDetailView(product: item.product)
//        } label: {
            WebImage(url: URL(string: item.product.thumbnail))
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .background(.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
//    }
}


private extension CartItemView {

    var productInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.product.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.black)
                .lineLimit(2)

            Text(String(format: "$%.2f", item.totalPrice))
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primaryOrange)

            quantitySelector
        }
    }
}


private extension CartItemView {

    var quantitySelector: some View {
        HStack(spacing: 8) {
            quantityButton(
                icon: "minus",
                isDisabled: item.quantity == 1,
                action: decreaseAction
            )

            Text("\(item.quantity)")
                .frame(width: 30, height: 30)
                .foregroundStyle(.black)

            quantityButton(
                icon: "plus",
                action: increaseAction
            )
        }
    }

    func quantityButton(
        icon: String,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .frame(width: 30, height: 30)
                .foregroundStyle(.primaryOrange)
                .background(.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
    }
}


private extension CartItemView {

    var removeButton: some View {
        Button(action: removeAction) {
            Image(systemName: "trash")
                .foregroundStyle(.red)
        }
        .buttonStyle(.plain)
    }
}
