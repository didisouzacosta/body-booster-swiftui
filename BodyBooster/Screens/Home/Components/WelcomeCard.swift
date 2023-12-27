//
//  WelcomeCard.swift
//  BodyBooster
//
//  Created by ProDoctor on 18/12/23.
//

import SwiftUI

struct WelcomeCard: View {
    
    let action: (String) -> Void
    
    private let phrase = "Você é mais forte do que pensa. Superer seus próprios limites!"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    Text("Bom dia Adriano.")
                    Text("Vamos treinar?")
                }.font(.system(size: 28, weight: .heavy))
                
                TouchableButton(
                    content: {
                        Text(phrase)
                    },
                    action: {
                        action(phrase)
                    }
                )
            }
            Spacer()
        }
        .padding(32)
        .foregroundStyle(.white)
        .background(.patternRed)
        .rounded()
    }
    
    // MARK: - Life Cicle
    
    init(action: @escaping (String) -> Void) {
        self.action = action
    }
    
}

#Preview {
    WelcomeCard { _ in }
}
