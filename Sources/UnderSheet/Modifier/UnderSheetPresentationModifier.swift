//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 03.04.2022.
//

import SwiftUI

struct UnderSheetPresentationModifier<SheetContent: View>: ViewModifier  {
    
    @Binding var isPresented: Bool
    
    let sheetContent: SheetContent
    
    public init(isPresented: Binding<Bool>, content: SheetContent) {
        self._isPresented = isPresented
        sheetContent = content
    }
    
    public func body(content: Content) -> some View {
        content
        .preference(key: UnderSheetStorage.Key.self, value: isPresented ? [.init(view: sheetContent)] : [])
    }
}


public extension View {
    func underSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(UnderSheetPresentationModifier(isPresented: isPresented, content: content()))
    }
}
