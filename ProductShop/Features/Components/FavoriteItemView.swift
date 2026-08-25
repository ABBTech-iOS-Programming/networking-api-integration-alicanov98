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
        HStack(spacing:12){
            WebImage(url: URL(string: product.thumbnail))
                .resizable()
                .scaledToFit()
                .frame(width: 90,height: 90)
                .background(.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading,spacing: 8) {
                Text(product.title)
                    .font(.system(size: 15,weight: .bold))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                Text(String(format: "$%.2f",product.price))
                    .foregroundStyle(.primaryOrange)
                    .font(.system(size: 16,weight: .bold))
            
            }
            Spacer()
            VStack{
                Button {
                    removeFromFavorite()
                } label: {
                    Image(systemName: "heart.fill")
                    .padding(12)
                    .font(.system(size: 16))
                    .background(.primaryOrange.opacity(0.1))
                    .foregroundStyle(.primaryOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                }
                Spacer()
                Button {
                    addToCart()
                } label: {
                    Image(systemName: "plus")
                        .padding(12)
                        .font(.system(size: 16))
                        .background(.primaryOrange)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                }
            }
            
        }
        .padding()
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
    }
}

//#Preview {
//    FavoriteItemView()
//}
