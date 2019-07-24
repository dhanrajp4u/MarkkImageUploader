//
//  ViewController.swift
//  MarkkImageUploader
//
//  Created by Dhanraj Subhash Bhandari on 24/07/19.
//  Copyright © 2019 Dhanraj Subhash Bhandari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnUpload: UIBarButtonItem!
    
    var photos:[Photo] = []
    
    //MARK:- Default Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Cloudinary"
        
        self.tblView.register(UINib.init(nibName: "ImageViewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ImageViewCellIdentifier")
        self.tblView.estimatedRowHeight = 150
        self.tblView.rowHeight = UITableView.automaticDimension
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photos = AppDelegate.photos
    }

    //MARK:- UIButton Action
    @IBAction func uploadImageBtnTapped(_ sender: Any) {
        let imagePiker = UIImagePickerController.init()
        imagePiker.sourceType = .savedPhotosAlbum
        imagePiker.delegate = self
        self.present(imagePiker, animated: true, completion: nil)
    }
    
}

//MARK:- UITableview Datasource
extension ViewController:  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tblView.dequeueReusableCell(withIdentifier: "ImageViewCellIdentifier") as? ImageViewTableViewCell {
            
            let photo = photos[indexPath.row]
             cell.configure(photo: photo, row: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
}
//MARK:- UIImagepicker Delegate
extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  @objc   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) {
        }
        if let image = info[UIImagePickerController.InfoKey.originalImage] {
            let photo = Photo.init(name: "Cloudinary \(photos.count)", publicid: nil, img: image as? UIImage)
            AppDelegate.photos.append(photo)
            photos = AppDelegate.photos
            
            self.tblView.insertRows(at: [IndexPath.init(row: photos.count-1, section: 0)], with: .automatic)
            
           // self.tblView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
