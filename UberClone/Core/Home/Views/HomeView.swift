//
//  HomeView.swift
//  UberClone
//
//  Created by Montserrat Gomez on 05/07/24.
//

import SwiftUI

struct HomeView: View {
	@State private var showLocationSearch: Bool = false
    var body: some View {
		ZStack(alignment: .top) {
			UberMapviewRepresentable()
				.ignoresSafeArea()
			
			MapActionButton()
				.padding(.horizontal)
			
			LocationSearchActivationView()
				.padding(.top, 72)
				.onTapGesture(perform: {
					showLocationSearch.toggle()
				})
			
		}
		
    }
}

#Preview {
    HomeView()
}
