//
//  ContentView.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 13/02/23.
//

import SwiftUI
enum Tabs {
	case Home
	case Favourite
}
struct TabsView: View {
	
    // variable
	@State private var selectedTab = Tabs.Home
	@ObservedObject var productsViewModel : ProductViewModel
	
	var body: some View {
		TabView(selection: $selectedTab) {
			
			NavigationView {
				ProductListScreen(productsViewModel: ProductListViewModel(products: productsViewModel.products, delegate: productsViewModel))
                    .navigationTitle(headerMessages.Product_List)
			}
			.tabItem {
				Label("Product List", systemImage: "list.bullet.rectangle.portrait")
			}
			.tag(Tabs.Home)
			
			NavigationView {
				ProductListScreen(productsViewModel: ProductListViewModel(products: productsViewModel.favProducts, delegate: productsViewModel))
					.navigationTitle("Favourites")
			}
			.tabItem {
				Label("Favourites", systemImage: "cart")
			}
			.tag(Tabs.Favourite)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			TabsView(productsViewModel: ProductViewModel())
		}
    }
}
