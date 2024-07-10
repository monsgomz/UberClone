//
//  LocationManager.swift
//  UberClone
//
//  Created by Montserrat Gomez on 05/07/24.
//
/*
 Sera el encargado de administrar la ubicacion y los permisos
 */

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
	private let locationManager = CLLocationManager()
	
	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest //para tener la ubicacion muy presisa
		locationManager.requestWhenInUseAuthorization() //requiere autorizacion
		locationManager.startUpdatingLocation() //actualiza la ubicacion, cuando se inicia, se actualiza varias veces
	}
	
	
}

extension LocationManager: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { ///Actualiza la ubicacion del ususario
		
		guard !locations.isEmpty else {return}
		locationManager.stopUpdatingLocation() //Se detiene cuando obtenemos la ubicacion
	}
}
