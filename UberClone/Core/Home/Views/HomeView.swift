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
			
			if showLocationSearch {
				LocationSearchView()
			} else {
				LocationSearchActivationView()
					.padding(.top, 72)
					.onTapGesture(perform: {
						withAnimation(.spring){
							showLocationSearch.toggle()
						}
						
					})
			}
			
			MapActionButton(showLocationSearchView: $showLocationSearch)
				.padding(.horizontal)
				.padding(.top, 2)
		}
		
    }
}

#Preview {
    HomeView()
}
