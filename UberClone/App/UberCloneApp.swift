//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Montserrat Gomez on 05/07/24.
//

import SwiftUI

@main
struct UberCloneApp: App {
	@StateObject var locationViewModel = LocationSearchViewModel() //solo una instancia
	
    var body: some Scene {
        WindowGroup {
           HomeView()
				.environmentObject(locationViewModel)
        }
    }
}
