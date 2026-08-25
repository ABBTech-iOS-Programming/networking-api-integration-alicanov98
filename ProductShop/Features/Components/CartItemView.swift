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
        HStack(spacing:12){
          
                WebImage(url: URL(string: item.product.thumbnail))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90,height: 90)
                    .background(.secondaryBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading,spacing: 8) {
                Text(item.product.title)
                    .font(.system(size: 15,weight: .bold))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                Text(String(format: "$%.2f",item.totalPrice))
                    .foregroundStyle(.primaryOrange)
                    .font(.system(size: 16,weight: .bold))
                HStack(spacing: 8) {
                    Button(action: decreaseAction) {
                        Image(systemName: "minus")
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.primaryOrange)
                            .background(.secondaryBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .disabled(item.quantity == 1)
                    
                    Text("\(item.quantity)")
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black)

                    Button(action: increaseAction) {
                        Image(systemName: "plus")
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.primaryOrange)
                            .background(.secondaryBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                   
                }
                .buttonStyle(.plain)
            }
            Spacer()
            Button(action: removeAction) {
                           Image(systemName: "trash")
                               .foregroundStyle(.red)
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
//    CartItemView()
//}
