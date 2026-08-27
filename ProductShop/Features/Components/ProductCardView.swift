//
//  ProductCardView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 24.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCardView: View {
     var product:Product
     let addToCart: () -> Void
    
    var body: some View {
        VStack (alignment: .leading){
            ZStack (alignment: .topLeading){
                WebImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray.opacity(0.5))
                        .padding(32)
                }
                .scaledToFit()
                .frame(height: 108)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(16)
                    
                
                
                HStack (spacing:4){
                    Image(systemName: "star.fill")
                        .font(.system(size: 13))
                    Text(product.rating.formatted(.number.precision(.fractionLength(0...2))))
                        .font(.system(size: 13, weight: .semibold))
                        .lineLimit(1)
                }
                .foregroundStyle(.primaryOrange)
            }
            VStack (alignment:.leading){
                Text(product.title)
                    .font(.system(size: 16,weight: .bold))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                Text(product.brand ?? "Brand")
                    .font(.system(size: 13,weight: .medium))
                    .foregroundStyle(Color(UIColor.secondaryLabel))
                    .lineLimit(1)
            }
            HStack {
                Text(String(format: "$%.2f", product.price))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)
                Spacer()
                Button {
                    addToCart()
                } label: {
                    Image(systemName: "plus")
                        .padding(16)
                        .background(.primaryOrange)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                }
            }
            
           
        }
        .padding(16)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


