//
//  LoadableViewState.swift
//  Bedrock
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import Foundation

enum LoadableViewState: Equatable {
	
	case initial, loading, success, empty([String : AnyHashable]?), error(Error)
	
	static func ==(lhs: LoadableViewState, rhs: LoadableViewState) -> Bool {
		switch (lhs, rhs) {
		case (.initial, .initial),
				 (.loading, .loading),
				 (.success, .success),
				 (.empty(_), .empty(_)),
				 (.error(_), .error(_)):
			return true
			
		default:
			return false
		}
	}
	
}
