//
//  StartButton.swift
//  BodyBooster
//
//  Created by ProDoctor on 26/12/23.
//

import SwiftUI

struct StartButton: View {
    let isStarted: Bool
    let isCompleted: Bool
    let action: () -> Void
    
    init(
        _ isStarted: Bool,
        isCompleted: Bool,
        action: @escaping () -> Void
    ) {
        self.isStarted = isStarted
        self.isCompleted = isCompleted
        self.action = action
    }
    
    private var title: String {
        isCompleted ? "Reiniciar treino" : isStarted ? "Em treino" : "Iniciar Treino"
    }
    
    private var scale: Double {
        !isStarted ? 1 : 0.9
    }
    
    private var padding: Double {
        !isStarted ? 8 : 0
    }
    
    var body: some View {
        TouchableButton(content: {
            Rectangle()
                .fill(.green)
                .frame(height: 70)
                .overlay {
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.black)
                }
                .rounded()
        }, action: action)
        .padding(.bottom, padding)
        .scaleEffect(scale)
        .disabled(isStarted)
    }
}

#Preview {
    StartButton(false, isCompleted: false) {}
}
