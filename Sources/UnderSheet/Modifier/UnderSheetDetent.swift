//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 18.04.2022.
//

import Foundation

public struct UnderSheetDetent: Equatable {
    var heightRatio: Double
    
    public init(ratio: Double) {
        heightRatio = ratio
    }
    
    public static let medium = UnderSheetDetent(ratio: 1/2)
    public static let large = UnderSheetDetent(ratio: 1)
}
