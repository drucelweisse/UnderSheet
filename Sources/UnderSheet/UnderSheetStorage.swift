//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 03.04.2022.
//

import Foundation
import SwiftUI

struct UnderSheetStorage: Equatable {
    static func == (lhs: UnderSheetStorage, rhs: UnderSheetStorage) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID
    var view: AnyView
    
    init<Content: View>(view: Content) {
        self.id = UUID()
        self.view = AnyView(view)
    }
}

struct UnderSheetStoragePreferenceKey: PreferenceKey {
    static var defaultValue: [UnderSheetStorage] = []
    static func reduce(value: inout [UnderSheetStorage], nextValue: () -> [UnderSheetStorage]) {
        value.append(contentsOf: nextValue())
    }
}
