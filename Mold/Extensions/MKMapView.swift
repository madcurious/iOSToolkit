//
//  MKMapView.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 7/12/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import MapKit

public extension MKMapView {
    
    public func removeAllAnnotations() {
        self.removeAnnotations(self.annotations)
    }
    
}
