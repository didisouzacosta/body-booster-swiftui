//
//  MinimalSectionModifier.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

extension View {
    
    func minimalSection() -> some View {
        modifier(MinimalSectionModifier())
    }
    
}

struct MinimalSectionModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 6)
            .padding(.horizontal, 16)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
    
}

#Preview {
    List {
        ForEach(Array(0...4), id: \.hashValue) { section in
            Section("Text") {
                ForEach(Array(0...3), id: \.hashValue) { row in
                    Text("Row: \(row)")
                }
            }
            .modifier(MinimalSectionModifier())
        }
    }
    .modifier(MinimalListModifier())
}
