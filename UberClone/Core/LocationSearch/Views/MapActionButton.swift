//
//  MapActionButton.swift
//  UberClone
//
//  Created by Montserrat Gomez on 08/07/24.
//

import SwiftUI

struct MapActionButton: View {
	
	@Binding var showLocationSearchView: Bool
	
    var body: some View {
		Button(action: {
			withAnimation(.spring){
				showLocationSearchView.toggle()
			}
		},
			   label: {
			Image(systemName: showLocationSearchView ? "arrow.backward" : "line.3.horizontal")
				.animation(.easeInOut(duration: 0.5))
				.font(.title)
				.foregroundStyle(Color.black)
				.padding()
				.background(Color.white)
				.clipShape(Circle())
				.shadow(color: .black, radius: 5)
		})
		.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
	MapActionButton(showLocationSearchView: .constant(false))
}
