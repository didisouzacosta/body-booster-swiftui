//
//  TouchableButton.swift
//  BodyBooster
//
//  Created by ProDoctor on 18/12/23.
//

import SwiftUI

struct TouchableButton<Content: View>: View {
    
    typealias Action = () -> Void
    
    // MARK: - Public Variables
    
    let content: () -> Content
    let action: Action
    
    var body: some View {
        Button(action: action) {
            content()
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Life Cicle
    
    init(
        @ViewBuilder content: @escaping () -> Content,
        action: @escaping Action
    ) {
        self.content = content
        self.action = action
    }
}

#Preview {
    TouchableButton(
        content: { Text("Adriano") }, 
        action: {}
    )
}
