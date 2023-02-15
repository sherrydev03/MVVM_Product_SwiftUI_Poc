//
//  MVVM_Projectwith_SwiftUIApp.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 13/02/23.
//

import SwiftUI

@main
struct MVVM_Projectwith_SwiftUIApp: App {
	@ObservedObject var productsViewModel = ProductViewModel()
	var body: some Scene {
		WindowGroup {
			ZStack {
				if productsViewModel.showLoader {
					ProgressView()
				} else {
					TabsView(productsViewModel: productsViewModel)
				}
			}
			.onAppear(perform: productsViewModel.fetchProducts)
		}
	}
}
