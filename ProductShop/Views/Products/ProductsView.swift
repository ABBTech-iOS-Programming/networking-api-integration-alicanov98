//
//  ProductsView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 20.08.26.
//

import SwiftUI


struct ProductsView: View {
    
    @State private var viewModel = ProductsViewModel(apiService: APIService())
    @State private var searchText = ""
    var column = [
        GridItem(.flexible(),spacing: 12),
        GridItem(.flexible(),spacing: 12)
    ]
    
    private var filteredProducts: [Product] {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return viewModel.products
        }

        return viewModel.products.filter { product in
            product.title.localizedCaseInsensitiveContains(searchText) ||
            product.category.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (spacing:16){
            bannerCard
                searchField
                category
                productsList
                
            }
         
        }
        .padding(.horizontal,16)
        .background(.primaryOrange.opacity(0.1))
        
    }
    
    var category: some View {
        ScrollView(.horizontal,showsIndicators: false){
        HStack{
                ForEach(viewModel.categories,id:\.self){ category in
                    Button{
                        Task {
                            await viewModel.fetchProducts(category: category == "All" ? nil : category)
                        }
                    } label: {
                        Text(category)
                            .padding(8)
                            .background(viewModel.selectedCategory == category ? .primaryOrange : .primaryOrange.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundStyle(viewModel.selectedCategory == category ? .white : .black)
                    }
                }
            }
        }
        .task {
          await  viewModel.fetchCategories()
        }
    }
    var productsList: some View {
        LazyVGrid(columns: column){
            ForEach(filteredProducts){ product in
                NavigationLink {
                ProductsDetailView(product: product)
                } label: {
                    ProductCardView(product:product)
                }
            }
        }
    }
    
    var bannerCard: some View {
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
    private var searchField: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search products", text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            if !searchText.isEmpty {
                Button {
                    searchText = ""
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
    ProductsView()
}
