//
//  MinimalList.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct MinimalList<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
        List() {
            content()
        }
        .listStyle(.grouped)
        .listSectionSpacing(0)
        .scrollIndicators(.hidden)
        .background(Color.background)
        .scrollContentBackground(.hidden)
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

#Preview {
    MinimalList {
        Section {
            Text("BodyBooster")
        }
    }
}
