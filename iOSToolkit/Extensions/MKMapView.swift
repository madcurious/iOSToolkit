//
//  MKMapView.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 7/12/15.
//  Copyright © 2015 Matthew Quiros. All rights reserved.
//

import MapKit

extension MKMapView {
	
	/// Removes all annotations from the map.
	func removeAllAnnotations() {
		removeAnnotations(annotations)
	}
	
}
