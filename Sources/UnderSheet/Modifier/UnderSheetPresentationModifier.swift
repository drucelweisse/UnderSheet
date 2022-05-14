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
  let detents: [UnderSheetDetent]
  
  public init(isPresented: Binding<Bool>, detents: [UnderSheetDetent], content: SheetContent) {
    self._isPresented = isPresented
    self.detents = detents
    sheetContent = content
  }
  
  public func body(content: Content) -> some View {
    content
      .preference(key: UnderSheetStorage.Key.self, value: isPresented ? [.init(view: sheetContent, isPresented: $isPresented, detents: detents)] : [])
  }
}


public extension View {
  func underSheet<Content: View>(isPresented: Binding<Bool>, detents: [UnderSheetDetent], @ViewBuilder content: @escaping () -> Content) -> some View {
    modifier(UnderSheetPresentationModifier(isPresented: isPresented, detents: detents, content: content()))
  }
}
