//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Montserrat Gomez on 10/07/24.
//

import SwiftUI
import MapKit

struct LocationSearchResultCell: View {
	var title: String
	var subttitle: String
	
    var body: some View {
		HStack(alignment: .center, spacing: 12){
			
			Image(systemName: "mappin.circle.fill")
				.resizable()
				.foregroundStyle(Color.blue)
				.aspectRatio(contentMode: .fill)
				.frame(width: 40, height: 40)
			
			VStack (alignment: .leading){
				Text(title)
					.font(.callout)
					.bold()
				Text(subttitle)
					.fontWeight(.light)
					.foregroundStyle(Color.gray)
				Divider()
			}
			.padding(.leading, 8)
			.padding(.vertical, 8)
		}
		.padding(.leading)
    }
}

#Preview {
	LocationSearchResultCell(title: "location", subttitle: "12345")
}
