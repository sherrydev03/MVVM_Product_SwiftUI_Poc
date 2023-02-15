//
//  FavourtiesViewModel.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 10/02/23.
//

import Foundation

class ProductListViewModel: ObservableObject {
	
    // variable
	@Published var products: [Product]
	
	weak var favouriteManager: FavouriteManager?
	
	init(products:[Product],delegate: FavouriteManager) {
		self.products = products
		self.favouriteManager = delegate
	}
	
}
