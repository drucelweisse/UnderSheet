//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 04.04.2022.
//

import SwiftUI

struct UnderSheetItemPresentationModifier<V: Identifiable, SheetContent: View>: ViewModifier {
  
  @Binding
  var item: V?
  let detents: [UnderSheetDetent]
  let sheetContent: (V) -> SheetContent
  
  @ViewBuilder
  func body(content: Content) -> some View {
    
    let sheetContent = item.map(sheetContent)
    
    let isPresented = Binding<Bool>(
      get: {
        item != nil
      },
      set: { newValue in
        if newValue {
          assertionFailure("Programmatic setter not supported")
        }
        item = nil
      })
    
    content
      .modifier(UnderSheetPresentationModifier(isPresented: isPresented, detents: detents, content: sheetContent))
  }
}


public extension View {
  func underSheet<V: Identifiable, Content: View>(item: Binding<V?>, detents: [UnderSheetDetent], @ViewBuilder content: @escaping (V) -> Content) -> some View {
    modifier(UnderSheetItemPresentationModifier(item: item, detents: detents, sheetContent: content))
  }
}
