//
//  MapActionButton.swift
//  UberClone
//
//  Created by Montserrat Gomez on 08/07/24.
//

import SwiftUI

struct MapActionButton: View {
    var body: some View {
		Button(action: {}, label: {
			Image(systemName: "line.3.horizontal")
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
    MapActionButton()
}
