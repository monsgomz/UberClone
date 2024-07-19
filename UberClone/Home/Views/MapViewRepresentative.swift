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

struct UberMapviewRepresentable: UIViewRepresentable { /// Necesita funciones obligatorias para que SwiftUI entienda que hacer (Parent View)
	
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
		if let coordinate = locationViewModel.selectedLocationCoordiate {
			context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
		}
		
	}
	
	func makeCoordinator() -> MapCoordinator { ///Se hace el coordinador
		return MapCoordinator(parent: self) //regresa las funciones a la vista
	}
	
	
}

extension UberMapviewRepresentable { ///Conecta con la vista del mapa
	
	class MapCoordinator: NSObject, MKMapViewDelegate { ///Este es el coordinador que hace todas las funciones
		
		//MARK: Propiedades
		let parent: UberMapviewRepresentable
		
		//MARK: LifeCycle
		init(parent: UberMapviewRepresentable) {
			self.parent = parent
			super.init()
		}
		
		//MARK: MKMapViewDelegate
		
		func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) { //Aqui se manejan todas las actualizacion de ubicacion
			let region = MKCoordinateRegion(
				center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			
			parent.mapView.setRegion(region, animated: true)
		}
		
		//MARK: Helpers
		
		///Para seleccionar la ubicacion y hacer la ruta
		func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			self.parent.mapView.addAnnotation(annotation) //añade la anotacion al mapa
			self.parent.mapView.selectAnnotation(annotation, animated: true) //va a estar seleccionada con pin grande
		}
		
	}
}

