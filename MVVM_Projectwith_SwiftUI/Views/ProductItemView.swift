//
//  ProductItemView.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 12/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductItemView: View {
	
    // variables
    @State private var showingAlert = false
	@ObservedObject var productItemViewModel: ProductItemViewModel
	@State private var isAnimated: Bool = false
	
	private let animationDuration = 0.1
	private var animationScale: CGFloat {
		productItemViewModel.product.isFavourite ? 1.1 : 0.9
	}

    var body: some View {
		NavigationLink {
			ProductDetailScreen(productItemViewModel: productItemViewModel)
		} label: {
			ZStack {
				background
				HStack {
					productImage
					VStack(alignment:.leading) {
						Spacer()
                        Text(productItemViewModel.product.title ?? AppErrorMessages.Not_available)
						Spacer()
						heartIcon
						Spacer()
						HStack {
							Text("$\(productItemViewModel.product.productPrice)")
							Spacer()
							addToCartButton
						}
						Spacer()
					}
					Spacer()
				}
				.frame(height: 150)
				.frame(maxWidth: .infinity)
			}
		}
		.buttonStyle(PlainButtonStyle())
    }
}

//MARK: -- Components--
extension ProductItemView {
	private var background: some View {
		Color(.white)
			.cornerRadius(8)
			.shadow(radius: 4)
	}
	
	private var productImage: some View {
 
        WebImage(url: productItemViewModel.product.imageUrl)
           .onSuccess { image, data, cacheType in
               // Success
           }
           .resizable()
           .placeholder(Image(systemName: "photo.fill")) // Placeholder Image
           
           .placeholder {
               Rectangle()
                   .foregroundColor(.white)
           }
           .indicator(.activity) // Activity Indicator
           .transition(.fade(duration: 0.5))
           .scaledToFit()
           .frame(width: 100,height: 150)
           .clipped()
		
//        WebImage(url: productItemViewModel.product.imageUrl)
//			.resizable()
//			.scaledToFit()
//			.frame(width: 100,height: 150)
//			.clipped()
	}
	
	private var heartIcon: some View {
		Image(systemName: productItemViewModel.product.isFavourite ? "heart.fill" : "heart")
			.resizable()
			.foregroundColor(.red)
			.font(.largeTitle)
			.frame(width: 30,height: 30)
			.scaleEffect(isAnimated ? animationScale : 1)
			.onTapGesture(perform: iconAction)
	}
	
	private var addToCartButton : some View {
		Button {
            showingAlert = true
		} label: {
			HStack(spacing: 0) {
				Image(systemName: "cart")
				Text("Add to cart")
			}
		}
        .alert(isPresented: $showingAlert) {
                   Alert(title: Text("Add to cart"), dismissButton: .default(Text("OK")))
               }
	}
}

//MARK:  ----- Methods-----
extension ProductItemView {
	
	private func iconAction() {
		guard let id = productItemViewModel.product.id else {return}
		productItemViewModel.delegateFavouriteManager?.updateFavourite(with: id)
		withAnimation(.easeIn(duration: animationDuration)) {
			isAnimated.toggle()
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
			withAnimation(.easeIn(duration: animationDuration)) {
				self.isAnimated.toggle()
			}
		}
	}
}



struct ProductItemView_Previews: PreviewProvider {
	static let product = Product(id: "1234", citrusId: "4", title: "Diamond", imageURL: "https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM", price: [Price(message: "", value: 4.0, isOfferPrice: false)], brand: "Rosemount", badges: nil, ratingCount: 4.0, messages: nil, isAddToCartEnable: nil, addToCartButtonText: nil, isInTrolley: nil, isInWishlist: nil, isFindMeEnable: nil, saleUnitPrice: nil, totalReviewCount: nil, isDeliveryOnly: nil, isDirectFromSupplier: nil)
	static var previews: some View {
		NavigationView {
			ProductItemView(productItemViewModel: ProductItemViewModel(product: product, delegateFavouriteManager: nil))
		}
	}
}
