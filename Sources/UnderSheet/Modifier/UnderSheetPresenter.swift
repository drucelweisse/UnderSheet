//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 03.04.2022.
//

import Foundation
import SwiftUI

struct UnderSheetPresenterModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .overlayPreferenceValue(UnderSheetStorage.Key.self, { storage in
        VStack {
          if let stored = storage.first {
            ResizableUnderSheetContainer(isPresented: stored.isPresented, detents: stored.detents, content: stored.view)
              .id(stored.id)
          }
        }
        .animation(.interactiveSpring(
          response: 0.55,
          dampingFraction: 0.85,
          blendDuration: 0), value: storage)
      })
    
  }
}


public extension View  {
  func underSheetPresenter() -> some View {
    modifier(UnderSheetPresenterModifier())
  }
}
