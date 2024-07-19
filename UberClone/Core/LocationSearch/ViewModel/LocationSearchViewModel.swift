//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Montserrat Gomez on 17/07/24.
// Es nuestro modelo de las busquedas del mapa

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
	
	//MARK: - properties
	
	@Published var results = [MKLocalSearchCompletion]() ///muestra los resultados de una String (se necesita NSObject)
	@Published var selectedLocationCoordiate: CLLocationCoordinate2D?
	
	private let searchCompleter = MKLocalSearchCompleter() ///El objeto que se usa para buscar la ubicacion
	var queryFragment: String = "" {
		didSet { //cada vez que se actualiza
//			print("Query fragment: \(queryFragment)")
			searchCompleter.queryFragment = queryFragment
		}
	}
	
	
	//MARK: Lifecycle
	override init() {
		super.init()
		searchCompleter.delegate = self
		searchCompleter.queryFragment = queryFragment //el query que estamos buscando
	}
	
	//MARK: Helpers
	
	///Permite obtener coordenada de la ubicacion
	func selectedLocation(_ localSearch: MKLocalSearchCompletion) {
		
		locationSearch(forLocationSearchCompletion: localSearch) { response, error in
			if let error = error {
				debugPrint("DEBUG: Error in location \(error.localizedDescription)")
				return
			}
			guard let item = response?.mapItems.first else { return }
			let coordinate = item.placemark.coordinate
			self.selectedLocationCoordiate = coordinate
			debugPrint("DEBUG: Selected location: \(coordinate)")
		}
		
	}
	
	///Se hace la busqueda a una cierta API
	func locationSearch(forLocationSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
		let searchRequest = MKLocalSearch.Request()
		searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle) //Para buscar la ubicacion completa
		let search = MKLocalSearch(request: searchRequest)
		search.start(completionHandler: completion)
	}
	
	
}

//MARK: Search complete delegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) { ///cuando el query se actualiza, llama esta funcion
		
		self.results = completer.results
		
	}
}
