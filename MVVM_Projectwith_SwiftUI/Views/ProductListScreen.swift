//
//  ProductListScreen.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 11/02/23.
//

import SwiftUI

struct ProductListScreen: View {
	
    // variable
	@ObservedObject var productsViewModel: ProductListViewModel
	
	var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(productsViewModel.products) { product in
					ProductItemView(productItemViewModel: ProductItemViewModel(product: product, delegateFavouriteManager: productsViewModel.favouriteManager))
				}
			}
			.padding(.horizontal)
		}
	}
}
	

struct ProductListScreen_Previews: PreviewProvider {
    static var previews: some View {
		ProductListScreen(productsViewModel: ProductListViewModel(products: [Product](), delegate: ProductViewModel()))
    }
}
