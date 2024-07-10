//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Montserrat Gomez on 08/07/24.
/*
 Vista para el momento de buscar una ubicación
 */

import SwiftUI

struct LocationSearchActivationView: View {
	@State var searchLocation: String = ""
    var body: some View {
		HStack {
			Rectangle()
				.fill(Color.black)
				.frame(width: 10, height: 10)
				.padding(.horizontal)
			
			TextField("Where to?", text: $searchLocation)
				.font(.callout)
				.foregroundStyle(Color.gray)
		}
		.frame(width: UIScreen.main.bounds.width - 64, height: 50)
		.background(
			Rectangle()
				.fill(Color.white)
				.shadow(color: .black, radius: 5)
		)
		
    }
}

#Preview {
    LocationSearchActivationView()
}
