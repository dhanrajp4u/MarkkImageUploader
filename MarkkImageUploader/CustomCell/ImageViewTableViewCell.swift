//
//  ImageViewTableViewCell.swift
//  MarkkImageUploader
//
//  Created by Dhanraj Subhash Bhandari on 24/07/19.
//  Copyright © 2019 Dhanraj Subhash Bhandari. All rights reserved.
//

import UIKit
import Cloudinary

class ImageViewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //MARK:- Default method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Configure cell according data
    func configure(photo: Photo, row:Int){
        self.imgView.image = nil
        if let publicId = photo.publicId {
            self.imgView.cldSetImage(publicId: publicId, cloudinary: AppDelegate.cloudinary!)
            
        }else{
            if let imge = photo.image,  let imageData = imge.jpegData(compressionQuality: 0.6){
                //let request =
                self.activityIndicator.startAnimating()
                self.imgView.image = imge
                AppDelegate.cloudinary?.createUploader().upload(data: imageData, uploadPreset: "dhanraj-preset", progress: { (progress) in
                    if progress.isFinished {
                        self.activityIndicator.stopAnimating()
                    }
                }, completionHandler: { (result, error) in
                    self.activityIndicator.stopAnimating()

                    if (error != nil){
                        print("Error in uploading.")
                    }else{
                        if let result = result,let publicid = result.publicId{
                             AppDelegate.photos[row].publicId = publicid
                            AppDelegate.photos[row].image = nil
                            self.imgView.cldSetImage(publicId: publicid, cloudinary: AppDelegate.cloudinary!)
                        }
                    }
                })
            }
        }
        
    }
}
