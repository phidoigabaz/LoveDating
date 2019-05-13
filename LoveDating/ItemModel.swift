//
//  ItemModel.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/13/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class ItemModel: NSObject {
    var title: String
    var imageView: UIImage
    
    init(_ title: String, _ imageView: UIImage) {
        self.title = title
        self.imageView = imageView
    }
}
