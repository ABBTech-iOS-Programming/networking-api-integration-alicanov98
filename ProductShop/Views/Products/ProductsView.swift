//
//  ProductsView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import SwiftUI


struct ProductsView: View {
    
    @State private var viewModel = ProductsViewModel(apiService: APIService())

    var column = [
        GridItem(.flexible(),spacing: 12),
        GridItem(.flexible(),spacing: 12)
    ]
    

    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (spacing:16){
                PromoBannerView()
                ProductSearchField(viewModel: viewModel)
                CategoryPickerView(viewModel: viewModel)
                contentView
            }
         
        }
        .padding(.horizontal,16)
        .background(.primaryOrange.opacity(0.1))
        .refreshable {
            await viewModel.refresh()
        }
    }
    

    @ViewBuilder
    var contentView: some View {
        if viewModel.isLoading {
            ProductGridSkeletonView()
        } else  if let errorMessage = viewModel.errorMessage {
            ErrorStateView(
                message: errorMessage,
                retryAction: {
                    Task {
                        await viewModel.refresh()
                    }
                }
            )
        } else if viewModel.filteredProducts.isEmpty {
            emptyView
        } else {
            productsList
        }
    }
    
    var productsList: some View {
        LazyVGrid(columns: column){
            ForEach(viewModel.filteredProducts){ product in
                NavigationLink {
                ProductsDetailView(product: product)
                } label: {
                    ProductCardView(product:product)
                }
            }
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "shippingbox")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)

            Text("No products found")
                .font(.headline)

            Text("Try another search or category.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
    
}

#Preview {
    ProductsView()
}
