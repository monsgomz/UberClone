//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Montserrat Gomez on 08/07/24.
/*
 Nuevo diseño es con sheet, el viejo es una view
 */

import SwiftUI

struct LocationSearchView: View {
	@State private var currentLocation = ""
	@State private var newLocation = ""
	
    var body: some View {
		VStack(alignment: .leading, spacing: 40){
			
			///Header view
			
			HStack(spacing: 1){
				VStack(spacing: 4){
					Circle()
						.fill(Color.gray)
						.frame(width: 10, height: 10)
						.padding(.horizontal, 10)
					Rectangle()
						.fill(Color.gray)
						.frame(width: 2, height: 35)
					Rectangle()
						.frame(width: 10, height: 10)
						.padding(.horizontal, 7)
					
				}
				
				VStack {
					TextField("Current Location", text: $currentLocation)
						.foregroundStyle(Color.gray)
						.frame(height: 32)
						.padding(5)
						.background(
							Rectangle()
								.fill(Color(.systemGray3))
								.opacity(0.6)
						)
					
					TextField("New Location", text: $newLocation)
						.frame(height: 32)
						.padding(5)
						.background(
							Rectangle()
								.fill(Color(.systemGray2))
								.opacity(0.6)
						)
				}
				.padding(.trailing)
			}
			.padding(.leading, 5)
			.padding(.top, 64)
			
			
			/// List View
				
			ScrollView {
				VStack{
					ForEach(0..<20, id: \.self) { _ in
						LocationSearchResultCell()
					}
				}
			}
			
			
			
			
			
		}
    }
}

#Preview {
    LocationSearchView()
}
