//
//  ProductSearchField.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct ProductSearchField: View {
    @Bindable var viewModel:ProductsViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search products", text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondaryOrange)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ProductSearchField(viewModel: ProductsViewModel(
        apiService: APIService()
    ))
}
