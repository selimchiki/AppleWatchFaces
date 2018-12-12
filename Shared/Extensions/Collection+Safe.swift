//
//  Collection+Contains.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/11/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
