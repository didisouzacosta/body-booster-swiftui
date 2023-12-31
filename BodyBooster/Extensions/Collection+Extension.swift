//
//  Collection+Extension.swift
//  BodyBooster
//
//  Created by ProDoctor on 28/12/23.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    func enumaredArray() -> [(index: Index, element: Element)] {
        Array(zip(indices, self))
    }
    
}
