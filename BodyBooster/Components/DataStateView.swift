//
//  DataStateView.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct DataStateView<Content: View, T, E: Error>: View {
    
    let state: DataState<T, E>
    let content: (T) -> Content
    
    var body: some View {
        switch state {
        case .loading:
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .padding()
            .minimalSection()
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loaded(let data):
            content(data)
        }
    }
    
    init(
        state: DataState<T, E>,
        content: @escaping (T) -> Content
    ) {
        self.state = state
        self.content = content
    }
}

#Preview("State: Loaded") {
    DataStateView(
        state: DataState<String, Error>.loaded("Adriano Souza Costa")
    ) { value in
        Text(value)
    }
}

#Preview("State: Loading") {
    DataStateView(
        state: DataState<String, Error>.loading
    ) { value in
        Text(value)
    }
}
