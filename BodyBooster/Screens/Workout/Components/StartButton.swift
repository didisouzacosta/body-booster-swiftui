//
//  StartButton.swift
//  BodyBooster
//
//  Created by ProDoctor on 26/12/23.
//

import SwiftUI

struct StartButton: View {
    let action: () -> Void
    
    var body: some View {
        TouchableButton(content: {
            Rectangle()
                .fill(.green)
                .frame(height: 70)
                .overlay {
                    Text("Iniciar treino")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.black)
                }
                .rounded()
        }, action: action)
    }
}

#Preview {
    StartButton() {}
}
