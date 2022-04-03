//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 03.04.2022.
//

import SwiftUI

public struct UnderSheetPresentationModifier<SheetContent: View>: ViewModifier  {
    
    @Binding var isPresented: Bool
    
    let sheetContent: SheetContent
    
    public init(isPresented: Bool, content: SheetContent) {
        self._isPresented = isPresented
        sheetContent = content
    }
    
    public func body(content: Content) -> some View {
        content
            .preference(key: UnderSheetStoragePreferenceKey.self, value: isPresented ? .init(view: sheetContent) : nil)
    }
}


public extension View {
    func underSheet<Content: View>(isPresented: Bool, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(UnderSheetPresentationModifier(isPresented: isPresented, content: content()))
    }
}
