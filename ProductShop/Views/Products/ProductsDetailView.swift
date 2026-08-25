//
//  ProductsDetailView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 24.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductsDetailView: View {
    var product:Product
    @State private var isFavorite = false
    @State private var quantity = 1
    @State private var selectedImageIndex = 0
    private var discountedPrice: Double {
        product.price * (1 - product.discountPercentage / 100)
    }
    
    private var totalPrice: Double {
        discountedPrice * Double(quantity)
    }
    
    var body: some View {
        VStack(alignment: .leading){
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
                Button{
                    isFavorite.toggle()
                }label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(.primaryOrange)
                }
            }
        }
    }
    
    private var productImagesView: some View {
        VStack(spacing:12) {
            TabView(selection: $selectedImageIndex) {
                ForEach(Array(product.images.enumerated()), id:\.offset) { index ,imageURL in
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
                ForEach(product.images.indices, id: \.self)
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
            Text("Essence Mascara Lash Princess")
                .font(.system(size: 16,weight: .bold))
            Text("\(product.category) • \(product.brand ?? "Unknown")")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
            HStack {
                HStack (spacing:14){
                    HStack(spacing:4){
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 13))
                    Text(product.rating.formatted(.number.precision(.fractionLength(0...2))))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.yellow)
                        .lineLimit(1)
                   }
                    Text("(\(product.reviews.count) reviews)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                }
                Spacer()
                Text("In stock: 5")
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
        VStack{
            Text("Description")
                .font(.system(size: 22,weight: .bold))
                .foregroundStyle(.black)
            Text(product.description)
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
                Button{
                    if quantity > 1 {
                        quantity -= 1
                    }
                }label: {
                    Image(systemName: "minus")
                                        .font(.system(size: 16, weight: .bold))
                                        .frame(width: 52, height: 52)
                                        .background(.secondaryBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(quantity == 1)
                .opacity(quantity == 1 ? 0.5 : 1)
                Text("\(quantity)")
                                .font(.system(size: 18, weight: .semibold))

                            Button {
                                quantity += 1
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(width: 52, height: 52)
                                    .background(.secondaryBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
            }
            .foregroundStyle(.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var bottomView: some View {
        HStack(alignment: .bottom, spacing: 20) {

            VStack(alignment: .leading, spacing: 4) {
                Text("Price")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)

                Text(String(format: "$%.2f", totalPrice))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.primaryOrange)
            }

            Spacer()

            Button {
                // Add to cart logic sonra
            } label: {
                Text("Add to Cart")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.primaryOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .frame(maxWidth: 260)
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
}
