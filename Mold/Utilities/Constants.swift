//
//  Constants.swift
//  Mold
//
//  Created by Matt Quiros on 21/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public let MDDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .long
    formatter.timeStyle = .long
    return formatter
}()
