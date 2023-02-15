//
//  ProductListViewModelTest.swift
//  MVVM_Projectwith_SwiftUITests
//
//  Created by Sherry Macbook on 13/02/23.
//

import XCTest
@testable import MVVM_Projectwith_SwiftUI

final class ProductListViewModelTest: XCTestCase {

	var productListViewModel: ProductListViewModel!
	var randomIndex: Int!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		let data = loadStub(name: "Products", extsn: "json")
		
		// Create JSON Decoder
		let decoder = JSONDecoder()
		
		// Configure JSON Decoder
		decoder.dateDecodingStrategy = .secondsSince1970
		
		// Decode JSON
		let productList = try decoder.decode(ProductList.self, from: data)
		let productsViewModel = ProductViewModel(products: productList.products!)
		randomIndex = Int.random(in: 0..<productList.products!.count)
		productListViewModel = ProductListViewModel(products: productsViewModel.products, delegate: productsViewModel)
    }
	
	func test_initilization() throws {
		XCTAssertNotNil(productListViewModel, "The product view model should not be nil.")
	}
	
	func test_loading_all_products() {
		XCTAssertNotEqual(productListViewModel.products.count, 0,"The count should not be equal to zero as we have loaded the products")
	}
	
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		productListViewModel = nil
    }

}
