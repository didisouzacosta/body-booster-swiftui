//
//  WaterCard.swift
//  BodyBooster
//
//  Created by ProDoctor on 18/12/23.
//

import SwiftUI

struct WaterCard: View {
    
    typealias Action = () -> Void
    
    // MARK: - Public Variables
    
    let action: Action
    
    var body: some View {
        TouchableButton(
            content: {
                VStack(alignment: .leading) {
                    Text("Vamos beber água?")
                    ProgressView(value: 20, total: 100)
                        .tint(.white)
                    HStack {
                        Text("0ml").bold()
                        Text("de")
                        Text("3000ml").bold()
                    }
                }
                .padding()
                .foregroundStyle(.white)
                .background(.patternBlue)
                .rounded()
            },
            action: action
        )
    }
    
    // MARK: - Life Cicle
    
    init(action: @escaping Action) {
        self.action = action
    }
}

#Preview {
    WaterCard { }
}
