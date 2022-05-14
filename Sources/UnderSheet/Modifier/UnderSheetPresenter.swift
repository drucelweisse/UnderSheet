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
                        stored.view
                            .background(Color(UIColor.systemBackground))
                            .ignoresSafeArea()
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .transition(.move(edge: .bottom))
                    }
                }

            })
        
    }
}


public extension View  {
    func underSheetPresenter() -> some View {
        modifier(UnderSheetPresenterModifier())
    }
}
