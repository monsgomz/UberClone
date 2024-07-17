//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Montserrat Gomez on 17/07/24.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
	
	//MARK: - properties
	
	@Published var results = [MKLocalSearchCompletion]() ///muestra los resultados de una String (se necesita NSObject)
	private let searchCompleter = MKLocalSearchCompleter() ///El objeto que se usa para buscar la ubicacion
	var queryFragment: String = "" {
		didSet { //cada vez que se actualiza
//			print("Query fragment: \(queryFragment)")
			searchCompleter.queryFragment = queryFragment
		}
	}
	
	override init() {
		super.init()
		searchCompleter.delegate = self
		searchCompleter.queryFragment = queryFragment //el query que estamos buscando
	}
	
	
	
	
	
}

//MARK: Search complete delegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) { ///cuando el query se actualiza, llama esta funcion
		
		self.results = completer.results
		
	}
}
