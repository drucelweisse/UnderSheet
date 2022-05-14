//
//  File.swift
//  
//
//  Created by Andrey Plotnikov on 18.04.2022.
//

import SwiftUI

struct ResizableUnderSheetContainer<Content: View>: View {
  @GestureState private var yTranslation: CGFloat = .zero
  @State private var selectedDetentIndex: Int = .zero
  @Binding var isPresented: Bool
  let detents: [UnderSheetDetent]
  let content: Content
  
  var body: some View {
    GeometryReader { proxy in
      content
        .coordinateSpace(name: "ResizableUnderSheet")
        .frame(width: proxy.size.width)
        .frame(height: max(frameHeight(index: selectedDetentIndex, height: proxy.size.height, translation: yTranslation), 0), alignment: .top)
        .background(background)
        .contentShape(Rectangle())
        .gesture(dragGesture(proxy: proxy))
        .animation(
          .interactiveSpring(
            response: 0.45,
            dampingFraction: 0.85,
            blendDuration: 0
          ),
          value: yTranslation
        )
    }
    .frame(maxHeight: .infinity, alignment: .bottom)
    .frame(maxWidth: .infinity)
    .transition(.move(edge: .bottom))
    .zIndex(1)
  }
}

private extension ResizableUnderSheetContainer {
  
  func dragGesture(proxy: GeometryProxy) -> some Gesture {
    DragGesture(coordinateSpace: .named("ResizableUnderSheet"))
      .updating($yTranslation, body: { value, state, transaction in
        state = value.translation.height
      })
      .onChanged({
        onDragEnded(value: $0, size: proxy.size)
      })
  }
  
  func onDragEnded(value: DragGesture.Value, size: CGSize) {
    if value.predictedEndTranslation.height > sheetHeight(index: selectedDetentIndex, height: size.height) / 2 {
      
      if value.predictedEndTranslation.height > sheetHeight(index: selectedDetentIndex, height: size.height) {
        isPresented = false
        return
      }
      
      if detents.indices.contains(selectedDetentIndex - 1) {
        selectedDetentIndex -= 1
        return
      }
      
      isPresented = false
      return
    }
    
    if value.predictedEndTranslation.height < -(sheetHeight(index: selectedDetentIndex, height: size.height) / 2) {
      let detent = detents[selectedDetentIndex]
      if case .medium = detent, detents.indices.contains(selectedDetentIndex + 1) {
        selectedDetentIndex += 1
        return
      }
    }
    
  }
  
  
  var background: some View {
      VStack(spacing: 0) {
          Color(UIColor.systemBackground)
      }
      .ignoresSafeArea(.all, edges: .bottom)
  }
  
  func sheetHeight(index: Int, height: CGFloat) -> CGFloat {
    height * detents[index].heightRatio
  }
  
  func frameHeight(index: Int, height: CGFloat, translation: CGFloat) -> CGFloat {
    sheetHeight(index: index, height: height) - translation
  }
  
}
