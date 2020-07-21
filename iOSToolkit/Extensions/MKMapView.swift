//
//  MKMapView.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 7/12/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import MapKit

extension MKMapView {
	
	/// Removes all annotations from the map.
	func removeAllAnnotations() {
		removeAnnotations(annotations)
	}
	
}
