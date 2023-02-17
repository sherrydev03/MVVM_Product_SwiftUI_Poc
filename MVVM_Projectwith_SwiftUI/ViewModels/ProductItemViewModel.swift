//
//  ProductItemViewModel.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 10/02/23.
//

import Foundation

class ProductItemViewModel: ObservableObject {
	// variable
	@Published var product: Product
	weak var delegateFavouriteManager : FavouriteManager?
	
	init(product: Product,delegateFavouriteManager: FavouriteManager?) {
		self.product = product
		self.delegateFavouriteManager = delegateFavouriteManager
	}
	
        // MARK: - func toggle for Favorite
	func toggleFavorite() {
		guard let id = product.id else {return}
		delegateFavouriteManager?.updateFavourite(with: id)
		product.isFavourite = !product.isFavourite
	}
}
