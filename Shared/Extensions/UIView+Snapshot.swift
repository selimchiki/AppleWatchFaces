//
//  UIView+Snapshot.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/22/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

extension UIView {
    func makeScreenshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { (context) in
            self.layer.render(in: context.cgContext)
        }
    }
    
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
