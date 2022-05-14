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
  var isPresented: Binding<Bool>
  var detents: [UnderSheetDetent]
  
  init<Content: View>(view: Content, isPresented: Binding<Bool>, detents: [UnderSheetDetent]) {
    self.id = UUID()
    self.view = AnyView(view)
    self.isPresented = isPresented
    self.detents = detents
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

