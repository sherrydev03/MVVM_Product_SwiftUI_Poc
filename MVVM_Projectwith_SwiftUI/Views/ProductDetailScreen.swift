//
//  ProductDetailScreen.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 12/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailScreen: View {
	
    // variable
	@ObservedObject var productItemViewModel: ProductItemViewModel
	@State private var isAnimated: Bool = false
	
	private let animationDuration = 0.2
	private var animationScale: CGFloat {
		productItemViewModel.product.isFavourite ? 1.1 : 0.9
	}
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				productImage
                Text(productItemViewModel.product.title ?? AppErrorMessages.No_Netowrk)
					.font(.largeTitle)
				Text(productItemViewModel.product.brand ?? AppErrorMessages.No_Netowrk)
					.font(.title3)
					.fontWeight(.semibold)
				HStack {
					heartIcon
					Spacer()
					StarRatingView(stars: productItemViewModel.product.ratingCount ?? 0)
				}
				Text("$\(productItemViewModel.product.productPrice)")
					.font(.largeTitle)
			}
            .navigationTitle(headerMessages.Product_Details)
			.navigationBarTitleDisplayMode(.inline)
			.padding()
		}
    }
}

//MARK: -- Components--
extension ProductDetailScreen {
	private var background: some View {
		Color(.white)
			.cornerRadius(8)
			.shadow(radius: 4)
	}
	
	private var productImage: some View {
//		WebImage(url: productItemViewModel.product.imageUrl)
//			.resizable()
//			.scaledToFit()
//			.frame(height: 300)
//			.frame(maxWidth: .infinity)
//			.clipped()
//			.cornerRadius(8)
        
        WebImage(url: productItemViewModel.product.imageUrl)
           .onSuccess { image, data, cacheType in
               // Success
           }
           .resizable()
           .placeholder(Image(systemName: "photo.fill")) // Placeholder Image
           .placeholder {
               Rectangle().foregroundColor(.white)
           }
           .indicator(.activity) // Activity Indicator
           .transition(.fade(duration: 0.5)) 
           .scaledToFit()
           .frame(height: 300)
           .frame(maxWidth: .infinity)
           .clipped()
           .cornerRadius(8)
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
		} label: {
			HStack(spacing: 0) {
				Image(systemName: "cart")
				Text("Add to cart")
			}
		}
	}
}

//MARK:  ----- Methods-----
extension ProductDetailScreen {
	
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


struct ProductDetailScreen_Previews: PreviewProvider {
	
	static let product = Product(id: "1234", citrusId: "4", title: "Diamond Label Shiraz", imageURL: "https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM", price: [Price(message: "", value: 4.0, isOfferPrice: false)], brand: "Rosemount", badges: nil, ratingCount: 4.0, messages: nil, isAddToCartEnable: nil, addToCartButtonText: nil, isInTrolley: nil, isInWishlist: nil, isFindMeEnable: nil, saleUnitPrice: nil, totalReviewCount: nil, isDeliveryOnly: nil, isDirectFromSupplier: nil)
	
    static var previews: some View {
		ProductDetailScreen(productItemViewModel: ProductItemViewModel(product: product, delegateFavouriteManager: nil))
    }
}
