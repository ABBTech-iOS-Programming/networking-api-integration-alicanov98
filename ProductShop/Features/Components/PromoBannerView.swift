//
//  PromoBannerView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct PromoBannerView: View {
    var body: some View {
            HStack{
                VStack(alignment: .leading,spacing:8){
                    Text("Good morning")
                        .font(.system(size: 12,weight: .medium))
                        .foregroundStyle(.secondaryText)
                    Text("Find your next favorite product")
                        .font(.system(size: 22,weight: .bold))
                        .foregroundStyle(.white)
                 
                    Text("Fresh picks for you")
                        .font(.system(size: 12,weight: .semibold))
                        .foregroundStyle(.secondaryOrange)
                }
                .padding(16)
                Spacer()
                VStack {
                    Text("20% OFF")
                        .font(.system(size: 12,weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.primaryOrange)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    Spacer()
                }.padding(16)
            }
            .background(.primaryText)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
}

#Preview {
    PromoBannerView()
}
