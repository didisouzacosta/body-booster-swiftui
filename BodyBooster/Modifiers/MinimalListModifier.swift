//
//  MinimalListModifier.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

extension View {
    
    func minimalList() -> some View {
        modifier(MinimalListModifier())
    }
    
}

struct MinimalListModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listStyle(.grouped)
            .scrollIndicators(.hidden)
            .background(Color.background)
            .scrollContentBackground(.hidden)
    }
    
}

#Preview {
    List {
        ForEach(Array(0...4), id: \.hashValue) { section in
            Section {
                ForEach(Array(0...3), id: \.hashValue) { row in
                    Text("Row: \(row)")
                }
            }
            .modifier(MinimalSectionModifier())
        }
    }
    .modifier(MinimalListModifier())
}
