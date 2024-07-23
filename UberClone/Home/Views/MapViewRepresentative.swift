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
			context.coordinator.configurationPolyline(withDestinationCoordinate: coordinate)
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
		var userLocationCoordinate: CLLocationCoordinate2D?
		
		//MARK: LifeCycle
		init(parent: UberMapviewRepresentable) {
			self.parent = parent
			super.init()
		}
		
		//MARK: MKMapViewDelegate
		
		func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) { //Aqui se manejan todas las actualizacion de ubicacion
			self.userLocationCoordinate = userLocation.coordinate
			let region = MKCoordinateRegion(
				center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			
			parent.mapView.setRegion(region, animated: true)
		}
		
		///para decirle al delegate que use esto al dibujar en overlay
		func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
			let polyline = MKPolylineRenderer(overlay: overlay)
			polyline.strokeColor = .magenta
			polyline.lineWidth = 6
			return polyline
		}
		
		//MARK: Helpers
		
		///Para seleccionar la ubicacion y mostrar solo 1 pin en el mapa
		func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
			parent.mapView.removeAnnotations(parent.mapView.annotations) //Remueve la ubicacion seleccionada
			
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			parent.mapView.addAnnotation(annotation) //añade la anotacion al mapa
			parent.mapView.selectAnnotation(annotation, animated: true) //va a estar seleccionada con pin grande
			parent.mapView.showAnnotations(parent.mapView.annotations, animated: true) //zoom a la ubicacion
		}
		
		///Crear la linea en el mapa
		func configurationPolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
			guard let userLocationCoordinate = self.userLocationCoordinate else { return }
			getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
				self.parent.mapView.addOverlay(route.polyline)
				
				
			}
			
		}
		
		///Crear la ruta
		func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
			
			let userPlacemark = MKPlacemark(coordinate: userLocation)
			let destPlacemark = MKPlacemark(coordinate: destination)
			var request = MKDirections.Request()
			
			request.source = MKMapItem(placemark: userPlacemark)
			request.destination = MKMapItem(placemark: destPlacemark)
			let direction = MKDirections(request: request)
			direction.calculate { response, error in
				if let error = error {
					debugPrint("DEBUG: Error en calculo direcciones")
					return
				}
				
				guard let route = response?.routes.first else { return }
				completion(route)
			}


		}
		
	}
}
 
