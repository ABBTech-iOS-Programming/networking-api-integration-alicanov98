//
//  ProductsDetailView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 24.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductsDetailView: View {
    @State private var viewModel: ProductsDetailViewModel
    @State private var selectedImageIndex = 0
    @Environment(FavoritesStore.self)
    private var favoritesStore
    
    init(product: Product) {
        _viewModel = State(initialValue: ProductsDetailViewModel(product: product))
    }
    
    
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack(alignment: .leading,spacing: 24){
                productImagesView
                productTitle
                description
                quantityView
                bottomView
            }
            .padding(.horizontal,16)
            .navigationTitle("Product Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    favoriteButton
                }
            }
        }
    }
    
    private var favoriteButton: some View {
            Button {
                favoritesStore.toggle(viewModel.product)
            } label: {
                Image(
                    systemName: favoritesStore.contains(viewModel.product)
                        ? "heart.fill"
                        : "heart"
                )
                .foregroundStyle(.primaryOrange)
            }
        }
    
    private var productImagesView: some View {
        VStack(spacing:12) {
            TabView(selection: $selectedImageIndex) {
                ForEach(Array(viewModel.product.images.enumerated()), id:\.offset) { index ,imageURL in
                    WebImage(url: URL(string: imageURL))
                                        .resizable()
                                        .scaledToFit()
                                        .padding(24)
                                        .tag(index)
                    
                }
            }
            .background((.slideBackground))
            .frame(height: 258)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack(spacing: 6) {
                ForEach(viewModel.product.images.indices, id: \.self)
                { index in
                Capsule()
                        .frame(width: selectedImageIndex == index ? 24 : 6, height: 6)
                        .foregroundStyle(selectedImageIndex == index ? .slideBackground : .secondaryText)
                }
            }
        }
    }
    
    private var productTitle: some View {
        VStack(alignment: .leading){
            Text(viewModel.product.title)
                .font(.system(size: 16,weight: .bold))
            Text("\(viewModel.product.category) • \(viewModel.product.brand ?? "Unknown")")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
            HStack {
                HStack (spacing:14){
                    HStack(spacing:4){
                    Image(systemName: "star.fill")
                        .foregroundStyle(.primaryOrange)
                        .font(.system(size: 13))
                        Text(viewModel.product.rating.formatted(.number.precision(.fractionLength(0...2))))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.primaryOrange)
                        .lineLimit(1)
                   }
                    Text("(\(viewModel.product.reviews.count) reviews)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                }
                Spacer()
                Text(viewModel.stockText)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.primaryGreen)
                    .padding(8)
                    .background(.secondaryGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            Divider()
        }
        
    }
    
    private var description: some View {
        VStack(alignment: .leading){
            Text("Description")
                .font(.system(size: 22,weight: .bold))
                .foregroundStyle(.black)
            Text(viewModel.product.description)
                .font(.system(size: 14,weight: .semibold))
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
    }
    
    private var quantityView:some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quantity")
            .font(.system(size: 18, weight: .bold))
                
            HStack(spacing: 20) {
                quantityButton(
                icon: "minus",
                isEnabled: viewModel.canDecreaseQuantity,
                action: viewModel.decreaseQuantity
                        )
                
                Text("\(viewModel.quantity)")
                     .font(.system(size: 18, weight: .semibold))
                     .frame(minWidth: 30)
                
                quantityButton(
                 icon: "plus",
                 isEnabled: viewModel.canIncreaseQuantity,
                 action: viewModel.increaseQuantity
                            )
            }
            .foregroundStyle(.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func quantityButton(
            icon: String,
            isEnabled: Bool,
            action: @escaping () -> Void
        ) -> some View {
            Button(action: action) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 52, height: 52)
                    .background(.secondaryBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .foregroundStyle(.primaryText)
            .disabled(!isEnabled)
            .opacity(isEnabled ? 1 : 0.5)
        }
    
    private var bottomView: some View {
        HStack(alignment: .bottom, spacing: 20) {

            VStack(alignment: .leading, spacing: 4) {
                Text("Price")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)

                Text(viewModel.formattedTotalPrice)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.primaryOrange)
            }

            Spacer()

            Button {
                viewModel.addToCart()
            } label: {
                Text("Add to Cart")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: 220)
                    .frame(height: 60)
                    .background(.primaryOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .frame(maxWidth: 200)
        }
    }
}

#Preview {
    ProductsDetailView( product: Product(
        id: 1,
        title: "Essence Mascara Lash Princess",
        description: "Popular mascara",
        category: "beauty",
        price: 9.99,
        discountPercentage: 10.48,
        rating: 4.5,
        stock: 99,
        tags: ["beauty", "mascara"],
        brand: "Essence",
        warrantyInformation: "1 week warranty",
        shippingInformation: "Ships in 3-5 business days",
        availabilityStatus: "In Stock",
        reviews: [],
        returnPolicy: "No return policy",
        minimumOrderQuantity: 1,
        images: ["https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp","https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp","https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp"],
        thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp"
    ))
    .environment(FavoritesStore())
}
