//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Montserrat Gomez on 10/07/24.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
		HStack(alignment: .center, spacing: 12){
			
			Image(systemName: "mappin.circle.fill")
				.resizable()
				.foregroundStyle(Color.blue)
				.aspectRatio(contentMode: .fill)
				.frame(width: 40, height: 40)
			
			VStack (alignment: .leading){
				Text("Street name")
					.font(.callout)
					.bold()
				Text("info street")
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
    LocationSearchResultCell()
}
