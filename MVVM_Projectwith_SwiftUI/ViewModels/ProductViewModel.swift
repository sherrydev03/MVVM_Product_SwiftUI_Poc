//
//  ProductViewModel.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 10/02/23.
//

import Foundation

protocol FavouriteManager: AnyObject {
	func updateFavourite(with id: String)
}

class ProductViewModel: ObservableObject {
    
   //  variable
	@Published var favProducts: [Product] = [Product]()
	@Published var products : [Product]
	@Published var showLoader: Bool = true
	@Published var errorMessage: String?
	
	init(products: [Product] = [Product]()) {
		self.products = products
		self.favouriteManager = self
	}
	
	weak var favouriteManager: FavouriteManager?
	
	// MARK: - fetchProducts
	func fetchProducts() {
		if Reachability.isConnectedToNetwork() {
			debugPrint("API Hit")
			APIManager.shared.request(
				modelType: ProductList.self,
				type: ProductEndPoint.newProducts) { [weak self] response in
					DispatchQueue.main.async {
						self?.showLoader = false
                        
					}
					switch response {
						case .success(let productList):
							guard let uwProducts = productList.products else{
								DispatchQueue.main.async {
									self?.errorMessage = AppErrorMessages.No_Products
								}
								return
							}
							DispatchQueue.main.async {
								self?.products = uwProducts
							}
						case .failure(let error):
							DispatchQueue.main.async {
								self?.errorMessage = error.localizedDescription
							}
					}
				}
		} else {
			showLoader = false
			errorMessage = AppErrorMessages.No_Netowrk
		}
	}
	
	private func updateFavouriteProducts(with product : Product) {
		guard let indexOfFavourite = favProducts.firstIndex(where: {$0.id == product.id}) else{
			favProducts.append(product)
			return
		}
		favProducts.remove(at: indexOfFavourite)
	}
}

    // MARK: - extension for ProductViewModel
extension ProductViewModel : FavouriteManager {
	func updateFavourite(with id: String) {
		guard let indexOfFavourite = products.firstIndex(where: {$0.id == id}) else{return}
		products[indexOfFavourite].isFavourite = !products[indexOfFavourite].isFavourite
		updateFavouriteProducts(with: products[indexOfFavourite])
		
	}
}

