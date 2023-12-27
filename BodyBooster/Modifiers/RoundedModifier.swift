//
//  RoundedModifier.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

extension View {
    
    func rounded(_ cornerRadius: CGFloat = 16) -> some View {
        modifier(RoundedModifier(cornerRadius: cornerRadius))
    }
    
}

struct RoundedModifier: ViewModifier {
    
    var cornerRadius: CGFloat = 16
    
    init(cornerRadius: CGFloat ) {
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
    
}
