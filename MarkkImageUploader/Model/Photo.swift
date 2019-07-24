//
//  Photo.swift
//  MarkkImageUploader
//
//  Created by Dhanraj Subhash Bhandari on 24/07/19.
//  Copyright © 2019 Dhanraj Subhash Bhandari. All rights reserved.
//

import Foundation
import UIKit

class Photo{
    var name: String
    var publicId: String?
    var image: UIImage?
    
    init(name: String, publicid: String?, img: UIImage?) {
        self.name = name
        self.publicId = publicid
        self.image = img
    }
}
