//
//  MapViewRepresentative.swift
//  UberClone
//
//  Created by Montserrat Gomez on 05/07/24.
//
/* Archivo que va a representa r al mapa mediante UIKIT y ponerlo con SwiftUI para tener mas funciones
 
 MKMapViewDelegate contiene las funcionalidades avanzadas para el mapa
 */

import Foundation
import SwiftUI
import MapKit

struct UberMapviewRepresentable: UIViewRepresentable { /// Necesita funciones obligatorias para que SwiftUI entienda que hacer
	
	let mapView = MKMapView()
	let locationManager = LocationManager()
	@EnvironmentObject var locationViewModel : LocationSearchViewModel //son instancias diferentes
	
	func makeUIView(context: Context) -> some UIView { ///Crea la vista para SwiftUI
		mapView.delegate = context.coordinator //el coordinador maneja todo
		mapView.isRotateEnabled = false
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
		
		return mapView
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) { ///Para actualizar la vista cuando el usuario cambia de lugar
		if let selectedLocation = locationViewModel.selectedLocation {
			debugPrint("DEBUG: Selected location in map \(selectedLocation)")
		}
		
	}
	
	func makeCoordinator() -> MapCoordinator { ///Se hace el coordinador
		return MapCoordinator(parent: self) //regresa las funciones a la vista
	}
	
	
}

extension UberMapviewRepresentable { ///Conecta con la vista del mapa
	
	class MapCoordinator: NSObject, MKMapViewDelegate { ///Este es el coordinador que hace todas las funciones
		let parent: UberMapviewRepresentable
		
		init(parent: UberMapviewRepresentable) {
			self.parent = parent
			super.init()
		}
		
		func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) { //Aqui se manejan todas las actualizacion de ubicacion  
			let region = MKCoordinateRegion(
				center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			
			parent.mapView.setRegion(region, animated: true)
		}
	}
}

