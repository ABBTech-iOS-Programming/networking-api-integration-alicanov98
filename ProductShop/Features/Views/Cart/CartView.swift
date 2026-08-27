//
//  CartView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct CartView: View {

    @Environment(CartStore.self) private var cartStore
    

    var body: some View {
        ScrollView {
            if cartStore.items.isEmpty {
                    emptyView
            } else {
                VStack(spacing: 16) {

                    ForEach(cartStore.items) { item in
                        NavigationLink {
                            ProductsDetailView(product: item.product)
                        } label: {
                            CartItemView(
                                item: item,
                                increaseAction: {
                                    cartStore.increaseQuantity(
                                        for: item.product
                                    )
                                },
                                decreaseAction: {
                                    cartStore.decreaseQuantity(
                                        for: item.product
                                    )
                                },
                                removeAction: {
                                    cartStore.remove(
                                        item.product
                                    )
                                }
                            )
                        }
                    }

                    totalView
                }
                .padding(16)
            }
        }
        .background(.primaryOrange.opacity(0.1))
        .navigationTitle("Cart")
    }

private var emptyView: some View {
        ContentUnavailableView(
            "Your Cart is Empty",
            systemImage: "cart",
            description: Text(
                "Products you add will appear here."
            )
        )
        .frame(maxWidth: .infinity)
        .frame(minHeight: 500)
}

    private var totalView: some View {
        HStack {
            Text("Total")
                .font(.headline)

            Spacer()

            Text(
                String(
                    format: "$%.2f",
                    cartStore.totalPrice
                )
            )
            .font(.title2.bold())
            .foregroundStyle(.primaryOrange)
        }
        .padding(.vertical)
    }
}


