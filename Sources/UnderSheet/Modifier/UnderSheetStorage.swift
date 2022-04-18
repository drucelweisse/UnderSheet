//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 06.04.2022.
//

import SwiftUI

struct UnderSheetStorage: Equatable {
    static func == (lhs: UnderSheetStorage, rhs: UnderSheetStorage) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID
    var view: AnyView
    var grabber: AnyView
    
    init<Content: View>(view: Content) {
        self.init(view: view, grabber: EmptyView())
    }
    
    init<Content: View, Grabber: View>(view: Content, grabber: Grabber) {
        self.id = UUID()
        self.view = AnyView(view)
        self.grabber = AnyView(grabber)
    }
}

extension UnderSheetStorage {
    struct Key: PreferenceKey {
        static var defaultValue: [UnderSheetStorage] = []
        static func reduce(value: inout [UnderSheetStorage], nextValue: () -> [UnderSheetStorage]) {
            value.append(contentsOf: nextValue())
        }
    }
}

