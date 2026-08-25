//
//  CategoryPickerView.swift
//  ProductShop
//
//  Created by Malik Alijanov on 25.08.26.
//

import SwiftUI

struct CategoryPickerView: View {
    var viewModel: ProductsViewModel
    var body: some View {
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
}

#Preview {
    CategoryPickerView(viewModel: ProductsViewModel(
        apiService: APIService()
    ))
}
