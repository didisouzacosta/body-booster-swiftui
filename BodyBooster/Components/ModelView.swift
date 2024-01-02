//
//  ModelView.swift
//  BodyBooster
//
//  Created by ProDoctor on 02/01/24.
//

import SwiftUI

struct ModelView<Content: View>: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let content: () -> Content
    
    var body: some View {
        content()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
}

#Preview {
    ModelView(content: { Text("Adriano") })
}
