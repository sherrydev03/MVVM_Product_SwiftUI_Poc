//
//  StarRatingView.swift
//  MVVM_Projectwith_SwiftUI
//
//  Created by Sherry Macbook on 13/02/23.
//

import SwiftUI

struct StarRatingView: View {
    
    // variable
	let stars : Double
	private let fullCount: Int
	private let emptyCount: Int
	private let halfFullCount: Int
	
	init(stars: Double) {
		self.stars = stars
		if floor(stars) == stars {
			fullCount = Int(stars)
			emptyCount = 5 - fullCount
		} else {
			fullCount = Int(stars)
			emptyCount = 5 - fullCount - 1
		}
		
		halfFullCount = (emptyCount+fullCount < 5) ? 1 : 0
	}
    
    
    var body: some View {
		HStack(spacing: 4) {
			ForEach(0..<fullCount) { _ in
				Image(systemName: "star.fill")
					.resizable()
					.frame(width: 30,height: 30)
			}
			ForEach(0..<halfFullCount) { _ in
				Image(systemName: "star.lefthalf.fill")
					.resizable()
					.frame(width: 30,height: 30)
			}
			ForEach(0..<emptyCount) { _ in
				Image(systemName: "star")
					.resizable()
					.frame(width: 30,height: 30)
			}
		}
		.foregroundColor(.blue)
		
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
		StarRatingView(stars: 3.1)
    }
}
